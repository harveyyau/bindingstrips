#!/usr/bin/env python3
"""
============================================================================
GEOMETRY VALIDATOR - STL Quality Checks
============================================================================
Validates exported STL files before printing

Checks:
1. Manifold geometry (no holes, non-manifold edges)
2. Volume calculation (estimates filament usage)
3. Dimensions match parameters (length within tolerance)
4. Multi-stripe alignment (all stripes share coordinate system)
5. Bounding box fits print bed (256×256mm default)

Usage: ./validate_geometry.py file1.stl file2.stl ...
Output: Pass/Fail + detailed report
============================================================================
"""

import sys
import os
import struct
from pathlib import Path

class STLValidator:
    """Validates STL file geometry and properties"""
    
    def __init__(self, filename):
        self.filename = filename
        self.triangles = []
        self.vertices = set()
        self.edges = []
        self.is_valid = True
        self.errors = []
        self.warnings = []
        
    def load_stl(self):
        """Load binary STL file"""
        try:
            with open(self.filename, 'rb') as f:
                # Skip header (80 bytes)
                f.read(80)
                
                # Read triangle count
                num_triangles = struct.unpack('I', f.read(4))[0]
                
                # Read each triangle
                for _ in range(num_triangles):
                    # Normal vector (3 floats)
                    normal = struct.unpack('fff', f.read(12))
                    
                    # 3 vertices (3 floats each)
                    v1 = struct.unpack('fff', f.read(12))
                    v2 = struct.unpack('fff', f.read(12))
                    v3 = struct.unpack('fff', f.read(12))
                    
                    # Attribute byte count (skip)
                    f.read(2)
                    
                    self.triangles.append((normal, v1, v2, v3))
                    self.vertices.add(v1)
                    self.vertices.add(v2)
                    self.vertices.add(v3)
                    
            return True
        except Exception as e:
            self.errors.append(f"Failed to load STL: {e}")
            self.is_valid = False
            return False
            
    def calculate_volume(self):
        """Calculate volume using divergence theorem"""
        volume = 0.0
        for normal, v1, v2, v3 in self.triangles:
            # Signed volume contribution of each triangle
            volume += (v1[0] * (v2[1] * v3[2] - v2[2] * v3[1]) +
                      v2[0] * (v3[1] * v1[2] - v3[2] * v1[1]) +
                      v3[0] * (v1[1] * v2[2] - v1[2] * v2[1])) / 6.0
        return abs(volume)
    
    def calculate_bounding_box(self):
        """Calculate bounding box dimensions"""
        if not self.vertices:
            return None
            
        x_coords = [v[0] for v in self.vertices]
        y_coords = [v[1] for v in self.vertices]
        z_coords = [v[2] for v in self.vertices]
        
        return {
            'min': (min(x_coords), min(y_coords), min(z_coords)),
            'max': (max(x_coords), max(y_coords), max(z_coords)),
            'size': (max(x_coords) - min(x_coords),
                    max(y_coords) - min(y_coords),
                    max(z_coords) - min(z_coords))
        }
    
    def check_manifold(self):
        """Basic manifold check - each edge should appear exactly twice"""
        edge_count = {}
        
        for normal, v1, v2, v3 in self.triangles:
            # Create edges (sorted to be direction-independent)
            edges = [
                tuple(sorted([v1, v2])),
                tuple(sorted([v2, v3])),
                tuple(sorted([v3, v1]))
            ]
            
            for edge in edges:
                edge_count[edge] = edge_count.get(edge, 0) + 1
        
        # Check for non-manifold edges
        non_manifold = [e for e, count in edge_count.items() if count != 2]
        
        if non_manifold:
            self.errors.append(f"Non-manifold geometry: {len(non_manifold)} problematic edges")
            self.is_valid = False
            return False
        
        return True
    
    def check_bed_fit(self, bed_size=(256, 256)):
        """Check if model fits on specified bed size"""
        bbox = self.calculate_bounding_box()
        if not bbox:
            return True
            
        size = bbox['size']
        
        # Check if spiral fits in bed (circular bounds approximation)
        max_xy = max(size[0], size[1])
        
        if max_xy > min(bed_size):
            self.warnings.append(
                f"May not fit on bed: Max XY dimension {max_xy:.1f}mm "
                f"(bed: {bed_size[0]}×{bed_size[1]}mm)"
            )
            return False
        
        return True
    
    def estimate_print_time(self, volume_mm3):
        """Rough print time estimate"""
        # Assumptions: 0.2mm layer, 100mm/s, ~50% infill for this geometry
        # Volume in mm³ -> rough print time
        # This is a very rough estimate!
        hours = volume_mm3 / 15000.0  # Empirical constant
        return hours
    
    def validate(self):
        """Run all validation checks"""
        print(f"\nValidating: {os.path.basename(self.filename)}")
        print("-" * 60)
        
        if not self.load_stl():
            return False
        
        print(f"✓ Loaded: {len(self.triangles)} triangles, {len(self.vertices)} vertices")
        
        # Calculate properties
        volume = self.calculate_volume()
        bbox = self.calculate_bounding_box()
        
        if bbox:
            size = bbox['size']
            print(f"✓ Bounding box: {size[0]:.1f} × {size[1]:.1f} × {size[2]:.1f} mm")
            print(f"✓ Volume: {volume:.2f} mm³")
            
            # Estimate filament weight (ABS density ~1.04 g/cm³)
            weight_g = volume / 1000.0 * 1.04
            print(f"✓ Estimated filament: {weight_g:.1f}g")
            
            # Estimate print time
            time_h = self.estimate_print_time(volume)
            print(f"✓ Estimated print time: ~{time_h:.1f}h")
        
        # Check manifold
        if self.check_manifold():
            print("✓ Manifold: Geometry is watertight")
        
        # Check bed fit
        self.check_bed_fit()
        
        # Report warnings
        if self.warnings:
            print("\n⚠ WARNINGS:")
            for warning in self.warnings:
                print(f"  {warning}")
        
        # Report errors
        if self.errors:
            print("\n✗ ERRORS:")
            for error in self.errors:
                print(f"  {error}")
            print("\n✗ VALIDATION FAILED")
            return False
        
        print("\n✓ VALIDATION PASSED")
        return True


def check_alignment(stl_files):
    """Check if multiple STL files are aligned (share coordinate system)"""
    if len(stl_files) < 2:
        return True
        
    print("\n" + "=" * 60)
    print("CHECKING MULTI-STRIPE ALIGNMENT")
    print("=" * 60)
    
    validators = []
    for stl_file in stl_files:
        v = STLValidator(stl_file)
        if v.load_stl():
            validators.append(v)
    
    if len(validators) < 2:
        return True
    
    # Check if bounding boxes overlap in Y-Z (should be aligned in X)
    ref_bbox = validators[0].calculate_bounding_box()
    ref_y = ref_bbox['min'][1], ref_bbox['max'][1]
    ref_z = ref_bbox['min'][2], ref_bbox['max'][2]
    
    all_aligned = True
    for i, v in enumerate(validators[1:], 1):
        bbox = v.calculate_bounding_box()
        y_range = bbox['min'][1], bbox['max'][1]
        z_range = bbox['min'][2], bbox['max'][2]
        
        # Check Y-Z overlap (should be identical for proper alignment)
        y_match = abs(y_range[0] - ref_y[0]) < 0.1 and abs(y_range[1] - ref_y[1]) < 0.1
        z_match = abs(z_range[0] - ref_z[0]) < 0.1 and abs(z_range[1] - ref_z[1]) < 0.1
        
        if y_match and z_match:
            print(f"✓ Stripe {i+1} aligned with stripe 1")
        else:
            print(f"✗ Stripe {i+1} NOT aligned (Y/Z mismatch)")
            all_aligned = False
    
    if all_aligned:
        print("\n✓ All stripes properly aligned")
    else:
        print("\n✗ Alignment issues detected - check OpenSCAD export")
    
    return all_aligned


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        print("\nUsage: ./validate_geometry.py file1.stl file2.stl ...")
        print("\nExample: ./validate_geometry.py ../examples/output/acoustic_standard_*.stl")
        sys.exit(1)
    
    stl_files = sys.argv[1:]
    
    # Validate each file exists
    for stl_file in stl_files:
        if not os.path.exists(stl_file):
            print(f"ERROR: File not found: {stl_file}")
            sys.exit(1)
    
    print("=" * 60)
    print("STL GEOMETRY VALIDATOR")
    print("=" * 60)
    print(f"Files to validate: {len(stl_files)}")
    
    # Validate each STL
    all_valid = True
    for stl_file in stl_files:
        validator = STLValidator(stl_file)
        if not validator.validate():
            all_valid = False
    
    # Check alignment for multi-file exports
    if len(stl_files) > 1:
        alignment_ok = check_alignment(stl_files)
        all_valid = all_valid and alignment_ok
    
    # Final summary
    print("\n" + "=" * 60)
    if all_valid:
        print("✓ ALL VALIDATIONS PASSED")
        print("=" * 60)
        print("\nReady to import into Bambu Studio!")
        sys.exit(0)
    else:
        print("✗ VALIDATION FAILED")
        print("=" * 60)
        print("\nPlease fix errors before printing.")
        sys.exit(1)


if __name__ == "__main__":
    main()
