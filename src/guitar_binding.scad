// ============================================================================
// PARAMETRIC GUITAR BINDING & PURFLING GENERATOR
// ============================================================================
// Generates 3D-printable binding and purfling strips as continuous spirals
// Designed for ABS printing on Bambu Lab printers (256×256mm bed)
//
// Repository: https://github.com/yourusername/bindingstrips
// License: MIT
// ============================================================================

// Import BOSL2 library for robust path sweeping
include <BOSL2/std.scad>

// ============================================================================
// CUSTOMIZER PARAMETERS
// ============================================================================
// Use OpenSCAD's Customizer (Window → Customizer) to adjust these via GUI

/* [Main Dimensions] */
strip_length_mm = 1000;  // [300:50:2000] Target usable length when uncoiled (mm)
strip_width_mm = 6.0;    // [3.0:0.5:10.0] Total width across all stripes (mm)
strip_height_mm = 1.0;   // [0.5:0.1:3.0] Thickness / Z-height (mm) - thinner for easier uncoiling

/* [Purfling Stripes] */
// Define color stripes as: [["Name", width_mm], ...]
// For single-color binding: [["Binding", 6.0]]
// For B-W-B purfling: [["Black", 2.0], ["White", 1.5], ["Black", 2.0]]
// Note: Total of widths must equal strip_width_mm
enable_purfling = false; // Enable multi-stripe purfling
purfling_stripe_1_name = "Black";
purfling_stripe_1_width = 2.0;  // [0:0.1:10] Width (mm)
purfling_stripe_2_name = "White";
purfling_stripe_2_width = 1.5;  // [0:0.1:10] Width (mm)
purfling_stripe_3_name = "Black";
purfling_stripe_3_width = 2.5;  // [0:0.1:10] Width (mm)

/* [Spiral Parameters] */
min_inner_radius_mm = 30;   // [20:1:50] Minimum bend radius (smaller = tighter coil, risk of cracking)
spiral_pitch_mm = 10.0;     // [8:0.5:20] Distance between coil centerlines (must be ≥ width + clearance)
clearance_mm = 4.0;         // [2.0:0.5:8.0] Extra gap between coils (prevents fusing during warp) - CRITICAL!

/* [Lead In/Out] */
lead_in_mm = 40;            // [20:5:100] Straight segment at start (for grabbing/clamping)
lead_out_mm = 40;           // [20:5:100] Straight segment at end

/* [Manufacturing] */
edge_radius_mm = 0.3;       // [0:0.05:1.0] Edge rounding radius (0 = sharp corners, >0 = rounded)
step_mm = 0.8;              // [0.3:0.1:2.0] Path sampling resolution (smaller = smoother + slower render)

/* [Advanced Options] */
tie_every_turns = 0;        // [0:1:5] Breakaway ties between coils (0 = disabled, 2 = recommended if warping)
tie_width_mm = 0.8;         // [0.5:0.1:2.0] Breakaway tie width
tie_thickness_mm = 0.6;     // [0.3:0.1:1.5] Breakaway tie thickness
kerf_allowance_mm = 0.0;    // [-0.5:0.05:0.5] Dimensional compensation for sanding/fitting
complete_coil_endpoint = true; // Complete current spiral turn for clean endpoint

/* [Export Control] */
export_part = "ALL";        // [ALL:Export all stripes, Binding:Single color binding, Black:Black stripe only, White:White stripe only, Custom:Use layer name]

// ============================================================================
// LAYER DEFINITION (programmatically constructed from Customizer params)
// ============================================================================

// Build layers array based on Customizer settings
function build_layers() = 
    enable_purfling ? [
        [purfling_stripe_1_name, purfling_stripe_1_width],
        [purfling_stripe_2_name, purfling_stripe_2_width],
        [purfling_stripe_3_name, purfling_stripe_3_width]
    ] : [
        ["Binding", strip_width_mm]
    ];

layers = build_layers();

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

// Sum all stripe widths to validate against total width
function sum_widths(l, i=0) =
    (i >= len(l)) ? 0 : l[i][1] + sum_widths(l, i+1);

// Calculate distance between two 3D points
function distance_3d(p1, p2) = 
    sqrt(pow(p2[0]-p1[0], 2) + pow(p2[1]-p1[1], 2) + pow(p2[2]-p1[2], 2));

// Normalize a 2D vector
function normalize_2d(v) = 
    let(mag = sqrt(v[0]*v[0] + v[1]*v[1]))
    mag > 0 ? [v[0]/mag, v[1]/mag] : [1, 0];

// Remove consecutive duplicate points from path (BOSL2 requirement)
function deduplicate_path(path, i=1, result=[]) =
    (len(path) == 0) ? [] :  // Empty path
    (i == 0) ? deduplicate_path(path, 1, [path[0]]) :  // Initialize with first point
    (i >= len(path)) ? result :  // Done
    let(
        last_pt = result[len(result)-1],
        curr_pt = path[i],
        dist = sqrt(pow(curr_pt[0]-last_pt[0], 2) + pow(curr_pt[1]-last_pt[1], 2) + pow(curr_pt[2]-last_pt[2], 2))
    )
    (dist < 0.001) ?  // Same point (within tolerance)
        deduplicate_path(path, i+1, result) :  // Skip duplicate
        deduplicate_path(path, i+1, concat(result, [path[i]]));  // Add point

// ============================================================================
// SPIRAL PATH GENERATOR
// ============================================================================
// Generates Archimedean spiral path with iterative length accumulation
// Returns list of [x, y, z] points including lead-in and lead-out segments

function spiral_points(
    target_len = strip_length_mm,
    r0 = min_inner_radius_mm,
    pitch = spiral_pitch_mm,
    step = step_mm,
    lead_in = lead_in_mm,
    lead_out = lead_out_mm,
    complete_turn = complete_coil_endpoint
) = 
    let(
        // Generate spiral core points
        spiral_core = generate_spiral_core(target_len, r0, pitch, step, complete_turn),
        
        // Extract first and last points for tangent calculation
        first_pt = spiral_core[0],
        second_pt = spiral_core[1],
        last_pt = spiral_core[len(spiral_core)-1],
        second_last_pt = spiral_core[len(spiral_core)-2],
        
        // Calculate tangent vectors
        start_tangent = normalize_2d([second_pt[0] - first_pt[0], second_pt[1] - first_pt[1]]),
        end_tangent = normalize_2d([last_pt[0] - second_last_pt[0], last_pt[1] - second_last_pt[1]]),
        
        // Generate lead-in (straight segment before spiral)
        lead_in_pts = [for (i=[0:step:lead_in]) 
            [first_pt[0] - start_tangent[0] * (lead_in - i),
             first_pt[1] - start_tangent[1] * (lead_in - i),
             0]
        ],
        
        // Generate lead-out (straight segment after spiral)
        lead_out_pts = [for (i=[step:step:lead_out]) 
            [last_pt[0] + end_tangent[0] * i,
             last_pt[1] + end_tangent[1] * i,
             0]
        ],
        
        // Combine all path segments
        full_path = concat(lead_in_pts, spiral_core, lead_out_pts),
        
        // Deduplicate consecutive duplicate points (BOSL2 requirement)
        clean_path = deduplicate_path(full_path)
    )
    clean_path;

// Generate spiral core with length accumulation
function generate_spiral_core(target_len, r0, pitch, step, complete_turn) =
    let(
        a = pitch / (2 * PI),  // Spiral constant
        result = generate_spiral_recursive(target_len, r0, a, step, 0, 0, [], complete_turn)
    )
    result;

// Recursive spiral generation with length tracking
function generate_spiral_recursive(
    target_len,
    r0,
    a,
    step,
    theta,
    accum_len,
    points,
    complete_turn,
    max_theta = 100  // Safety limit: ~16 full rotations
) =
    // Stop conditions
    (theta > max_theta) ? points :  // Safety limit
    (!complete_turn && accum_len >= target_len) ? points :  // Exact length reached
    (complete_turn && accum_len >= target_len && (theta % (2*PI)) < 0.1) ? points :  // Complete turn
    
    let(
        // Calculate current point on Archimedean spiral
        r = r0 + a * theta,
        x = r * cos(theta * 180 / PI),
        y = r * sin(theta * 180 / PI),
        current_pt = [x, y, 0],
        
        // Calculate length increment
        len_increment = (len(points) == 0) ? 0 : distance_3d(points[len(points)-1], current_pt),
        new_accum_len = accum_len + len_increment,
        
        // Adaptive step: smaller delta_theta as radius increases (maintains consistent chord length)
        delta_theta = step / max(r, r0),
        new_points = concat(points, [current_pt])
    )
    generate_spiral_recursive(
        target_len, r0, a, step, 
        theta + delta_theta, 
        new_accum_len, 
        new_points,
        complete_turn,
        max_theta
    );

// ============================================================================
// STRIPE GEOMETRY MODULES
// ============================================================================

// 2D profile for a stripe cross-section (with optional edge rounding)
module stripe_profile(width, height, radius=edge_radius_mm) {
    if (radius > 0 && radius < min(width, height) / 2) {
        // Rounded rectangle using offset trick
        offset(r=radius) 
        offset(delta=-radius) 
        square([width, height], center=false);
    } else {
        // Sharp corners
        square([width, height], center=false);
    }
}

// Sweep a 2D profile along a 3D path using BOSL2
module swept_stripe(path_pts, width, height, radius=edge_radius_mm) {
    // Create 2D profile
    profile_2d = path2d([
        [0, 0],
        [width, 0],
        [width, height],
        [0, height]
    ]);
    
    // Apply edge rounding if specified
    profile = (radius > 0 && radius < min(width, height) / 2) ?
        round_corners(profile_2d, radius=radius) :
        profile_2d;
    
    // Sweep profile along path
    path_sweep(profile, path3d(path_pts), closed=false, twist=0);
}

// ============================================================================
// BREAKAWAY TIE GENERATION (optional stabilization feature)
// ============================================================================

module generate_ties(path_pts, pitch, width, tie_width, tie_thickness, tie_interval) {
    if (tie_interval > 0) {
        // Calculate tie positions between coils
        num_ties = floor(len(path_pts) / (tie_interval * 100));
        for (i = [1:num_ties]) {
            tie_idx = i * tie_interval * 100;
            if (tie_idx < len(path_pts) - 1) {
                // Place small connecting bridge between adjacent coil turns
                tie_pt = path_pts[tie_idx];
                translate([tie_pt[0], tie_pt[1], 0])
                rotate([0, 0, atan2(tie_pt[1], tie_pt[0])])
                translate([pitch/2 - tie_width/2, -width/2, 0])
                cube([tie_width, width, tie_thickness]);
            }
        }
    }
}

// ============================================================================
// MAIN GEOMETRY GENERATION
// ============================================================================

// Parameter validation
total_stripe_width = sum_widths(layers);
width_tolerance = 0.01;

assert(
    abs(total_stripe_width - strip_width_mm) < width_tolerance,
    str("ERROR: Layer widths sum to ", total_stripe_width, "mm but strip_width_mm is ", strip_width_mm, "mm")
);

assert(
    spiral_pitch_mm >= strip_width_mm + clearance_mm,
    str("ERROR: spiral_pitch_mm (", spiral_pitch_mm, ") must be >= strip_width_mm (", strip_width_mm, ") + clearance_mm (", clearance_mm, ") = ", strip_width_mm + clearance_mm)
);

echo(str("=== GUITAR BINDING GENERATOR ==="));
echo(str("Target length: ", strip_length_mm, "mm"));
echo(str("Strip dimensions: ", strip_width_mm, "mm × ", strip_height_mm, "mm"));
echo(str("Layers: ", len(layers), " stripe(s)"));
echo(str("Spiral pitch: ", spiral_pitch_mm, "mm, Inner radius: ", min_inner_radius_mm, "mm"));
echo(str("Generating path... (this may take 30-60 seconds)"));

// Generate spiral path
path = spiral_points();

echo(str("Path generated: ", len(path), " points"));
echo(str("Rendering stripes..."));

// Render each stripe
x_offset = 0;
for (i = [0:len(layers)-1]) {
    stripe_name = layers[i][0];
    stripe_width = layers[i][1] + kerf_allowance_mm;  // Apply kerf compensation
    
    // Check if this stripe should be exported
    should_export = (export_part == "ALL") || 
                    (export_part == stripe_name) ||
                    (export_part == "Binding" && !enable_purfling);
    
    if (should_export) {
        echo(str("  Rendering stripe: ", stripe_name, " (", stripe_width, "mm × ", strip_height_mm, "mm)"));
        
        // Translate stripe to correct position across width
        translate([x_offset, 0, 0])
        swept_stripe(path, stripe_width, strip_height_mm, edge_radius_mm);
    }
    
    x_offset = x_offset + layers[i][1];  // Note: use original width for offset, not compensated
}

// Optional: Generate breakaway ties
if (tie_every_turns > 0) {
    echo(str("Adding breakaway ties (every ", tie_every_turns, " turns)"));
    generate_ties(path, spiral_pitch_mm, strip_width_mm, tie_width_mm, tie_thickness_mm, tie_every_turns);
}

echo(str("=== RENDER COMPLETE ==="));
echo(str("Export this with: openscad -o output.stl ", $preview ? "guitar_binding.scad" : ""));
