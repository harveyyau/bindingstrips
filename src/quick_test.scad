// ============================================================================
// QUICK TEST - Fast Render Version
// ============================================================================
// Renders a 300mm test coil in ~30 seconds for rapid iteration
// Use this to validate parameters before committing to a full-length print
// ============================================================================

include <guitar_binding.scad>

// OVERRIDE: Short length for fast rendering
strip_length_mm = 300;  // Renders much faster than 1000mm+

// Use optimized parameters that prevent overlap
min_inner_radius_mm = 30;
spiral_pitch_mm = 10.0;
clearance_mm = 4.0;
strip_height_mm = 1.0;  // Thinner for testing

// All other parameters inherited from guitar_binding.scad
// Adjust via Customizer or by adding overrides here

echo("=== QUICK TEST MODE ===");
echo("Rendering 300mm test coil with NO OVERLAP - should complete in 30-60 seconds");
