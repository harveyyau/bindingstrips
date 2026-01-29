// ============================================================================
// QUICK TEST - Fast Render Version
// ============================================================================
// Renders a 300mm test coil in ~30 seconds for rapid iteration
// Use this to validate parameters before committing to a full-length print
// ============================================================================

include <guitar_binding.scad>

// OVERRIDE: Short length for fast rendering
strip_length_mm = 300;  // Renders much faster than 1000mm+

// All other parameters inherited from guitar_binding.scad
// Adjust via Customizer or by adding overrides here

echo("=== QUICK TEST MODE ===");
echo("Rendering 300mm test coil - should complete in 30-60 seconds");
