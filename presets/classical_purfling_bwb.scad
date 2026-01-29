// ============================================================================
// CLASSICAL PURFLING (Black-White-Black)
// ============================================================================
/*
  FOR: Classical guitar rosette purfling, decorative inlay
  
  TYPICAL USE: Rosette decoration, soundhole rings, decorative accents
  THIS PRESET PRODUCES: ~1400mm usable length (bed-filling spiral!)
  
  STRATEGY: Fills entire 240mm bed diameter for MAXIMUM outer bend radius
  → Starts at bed edge (120mm radius), spirals INWARD to center
  → Three separate color stripes: Black-White-Black pattern
  → Outer coils have gentle radius = easy to install around curves
  
  PRINT TIME: ~2-3 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~35g ABS total (3 colors)
    - Black: ~20g (two stripes: 0.75mm each)
    - White: ~15g (center stripe: 0.5mm)
  BED REQUIREMENT: Fills Bambu X1/P1S (256×256mm bed) completely
  
  DIMENSIONS: Total 2.0mm WIDE × 6mm TALL
  - Black outer: 0.75mm wide
  - White center: 0.5mm wide
  - Black outer: 0.75mm wide
  - Total: 2.0mm wide × 6mm tall
  
  EXPORT: Generates 3 separate STL files (one per color)
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters - Narrower for purfling
strip_length_mm = 1600;  // [1000:100:3000] Target length
strip_width_mm = 2.0;    // Total width (sum of all stripes)
strip_height_mm = 6.0;   // Standard height

// ENABLE MULTI-STRIPE PURFLING
enable_purfling = true;

// Black-White-Black pattern
purfling_stripe_1_name = "Black";
purfling_stripe_1_width = 0.75;
purfling_stripe_2_name = "White";
purfling_stripe_2_width = 0.5;
purfling_stripe_3_name = "Black";
purfling_stripe_3_width = 0.75;

layers = [
    ["Black", 0.75],
    ["White", 0.5],
    ["Black", 0.75]
];

// BED-FILLING INWARD SPIRAL
max_bed_diameter_mm = 240;  // Full bed
min_center_radius_mm = 10;  // Spiral to center
clearance_mm = 1.0;         // 1mm gap (pitch auto = 2.0+1.0=3.0mm)

echo("=== CLASSICAL PURFLING (B-W-B, Inward Spiral) ===");
echo("For: Classical guitar rosette, decorative inlay");
echo("Output: ~1600mm × 2.0mm WIDE × 6mm TALL (fills 240mm bed)");
echo("Stripes: Black (0.75mm) + White (0.5mm) + Black (0.75mm)");
echo("Spiral: 120mm outer radius → 10mm inner");
