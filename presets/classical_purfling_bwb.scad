// ============================================================================
// CLASSICAL PURFLING (Black-White-Black)
// ============================================================================
/*
  FOR: Classical guitar rosette purfling, decorative inlay
  
  TYPICAL USE: Rosette decoration, soundhole rings, decorative accents
  THIS PRESET PRODUCES: 600mm usable length (includes 15% safety margin)
  
  PRINT TIME: ~3-4 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~25g ABS total (3 colors: Black, White, Black)
    - Black: ~15g (two outer stripes)
    - White: ~10g (center stripe)
  BED REQUIREMENT: Fits Bambu X1/P1S (256×256mm bed)
  
  DIMENSIONS:
  - Total width: 5.5mm (Black 2mm + White 1.5mm + Black 2mm)
  - Thickness: 1.2mm (thinner for decorative use)
  - Three colors: BLACK-WHITE-BLACK pattern
  
  STRIPE LAYOUT:
  - Outer Black: 2.0mm wide
  - Center White: 1.5mm wide  
  - Outer Black: 2.0mm wide
  - Total: 5.5mm
  
  EXPORT WORKFLOW:
  1. Run: ./scripts/print_this.sh classical_purfling_bwb
  2. This generates 3 separate STL files:
     - classical_purfling_bwb_L600_W5.5_H1.2_Black.stl (outer stripes combined)
     - classical_purfling_bwb_L600_W5.5_H1.2_White.stl (center stripe)
  3. Import .3mf into Bambu Studio
  4. Assign filaments: Black to P1, White to P2, Black to P3
  
  INSTALLATION TIPS:
  - Stripes are perfectly flush (seamless appearance)
  - Uncoil carefully - thinner than binding, more delicate
  - Can be bent to tighter radius than thicker binding
  - Test fit in rosette channel before gluing
  
  TO CUSTOMIZE:
  - Open in OpenSCAD
  - Use Window → Customizer to adjust stripe widths individually
  - Or edit parameters below directly
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters for classical purfling
strip_length_mm = 600;   // [300:50:2000] Usable length after uncoiling
strip_width_mm = 5.5;    // Total width (sum of all stripes)
strip_height_mm = 1.2;   // [1.0:0.1:3.0] Thinner for decorative use

// ENABLE MULTI-STRIPE PURFLING
enable_purfling = true;

// Black-White-Black pattern
purfling_stripe_1_name = "Black";
purfling_stripe_1_width = 2.0;
purfling_stripe_2_name = "White";
purfling_stripe_2_width = 1.5;
purfling_stripe_3_name = "Black";
purfling_stripe_3_width = 2.0;

layers = [
    ["Black", 2.0],
    ["White", 1.5],
    ["Black", 2.0]
];

// Recommended spiral parameters for this size
min_inner_radius_mm = 12;  // Can be tighter due to thinner strip
spiral_pitch_mm = 7.5;
clearance_mm = 2.0;

echo("=== CLASSICAL PURFLING (B-W-B) ===");
echo("For: Classical guitar rosette, decorative inlay");
echo("Output: 600mm × 5.5mm × 1.2mm");
echo("Stripes: Black (2mm) + White (1.5mm) + Black (2mm)");
