// ============================================================================
// FULL GENERATION TEST FILE
// ============================================================================
// No more "quick test" - always do full generation
// This file kept for testing but uses same parameters as full presets
// ============================================================================

include <guitar_binding.scad>

// Full generation parameters (same as acoustic_standard)
strip_length_mm = 1600;     // Full typical binding length
strip_width_mm = 1.5;       // THIN (horizontal)
strip_height_mm = 6.0;      // TALL (vertical Z)
max_bed_diameter_mm = 240;  // Full bed
min_center_radius_mm = 10;  // Spiral to center for maximum length
clearance_mm = 1.0;         // 1mm gap

echo("=== FULL GENERATION TEST ===");
echo("1600mm binding on FULL 240mm bed diameter");
echo("Spiral starts at outer edge, goes INWARD to center");
