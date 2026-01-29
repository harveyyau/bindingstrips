# BOSL2 Library Setup

The guitar binding generator requires the **BOSL2** (Belfry OpenSCAD Library v2) for robust path sweeping and geometry operations.

This is a **one-time setup** that takes about 10 minutes.

---

## What is BOSL2?

BOSL2 is a comprehensive library for OpenSCAD that provides:
- Advanced path manipulation (`path_sweep`)
- Robust 2D/3D transformations
- Better geometry primitives
- Reliable manifold generation

Our binding generator uses BOSL2's `path_sweep()` function to sweep the binding profile along the spiral path, creating clean, manifold geometry.

---

## Installation Steps

### Step 1: Download BOSL2

Visit the official BOSL2 GitHub repository:
**https://github.com/BelfrySCAD/BOSL2**

**Option A: Download ZIP (Easiest)**
1. Click the green "Code" button
2. Select "Download ZIP"
3. Extract the ZIP file to a temporary location

**Option B: Git Clone**
```bash
git clone https://github.com/BelfrySCAD/BOSL2.git
```

---

### Step 2: Locate OpenSCAD Libraries Folder

The libraries folder location varies by operating system:

#### macOS
```
~/Documents/OpenSCAD/libraries/
```

If the folder doesn't exist, create it:
```bash
mkdir -p ~/Documents/OpenSCAD/libraries/
```

#### Linux
```
~/.local/share/OpenSCAD/libraries/
```

Create if needed:
```bash
mkdir -p ~/.local/share/OpenSCAD/libraries/
```

#### Windows
```
C:\Users\<YourUsername>\Documents\OpenSCAD\libraries\
```

Or check OpenSCAD → Help → Library Info for the exact path.

---

### Step 3: Install BOSL2

Copy the **entire BOSL2 folder** into the libraries directory:

#### macOS / Linux
```bash
cp -r BOSL2/ ~/Documents/OpenSCAD/libraries/
```

#### Windows
Use File Explorer to copy the `BOSL2` folder into the libraries directory.

**Result:** You should have a structure like:
```
~/Documents/OpenSCAD/libraries/
└── BOSL2/
    ├── std.scad
    ├── beziers.scad
    ├── geometry.scad
    └── ... (many other files)
```

---

### Step 4: Verify Installation

Open OpenSCAD and create a new file with this test code:

```scad
include <BOSL2/std.scad>

// Simple test: If this renders without errors, BOSL2 is installed correctly
cube([10, 10, 10]);

echo("✓ BOSL2 is installed correctly!");
```

**Click F5 (Preview) or F6 (Render)**

**Expected result:**
- Cube appears in the viewer
- Console shows: `✓ BOSL2 is installed correctly!`
- **No error messages**

---

## Troubleshooting

### Error: "Can't find file 'BOSL2/std.scad'"

**Cause:** BOSL2 not in the correct libraries folder

**Solutions:**

1. **Verify folder structure:**
   ```bash
   ls ~/Documents/OpenSCAD/libraries/BOSL2/
   ```
   Should show many `.scad` files including `std.scad`

2. **Check OpenSCAD library path:**
   - OpenSCAD → Edit → Preferences → Libraries
   - Note the path shown
   - Ensure BOSL2 is in that location

3. **Folder naming:**
   - Folder must be named **exactly** `BOSL2` (case-sensitive on Linux/macOS)
   - Not `BOSL2-master` or `BOSL2-main`

---

### Error: "Recursive include"

**Cause:** BOSL2 files are incorrectly nested or duplicated

**Solution:**
- Remove BOSL2 completely from libraries folder
- Re-extract/copy following Step 3 exactly
- Ensure folder structure matches above

---

### OpenSCAD Crashes on Render

**Cause:** Older OpenSCAD version incompatible with BOSL2

**Solution:**
- Update OpenSCAD to latest version (2021.01 or newer)
- Download from: https://openscad.org/downloads.html
- BOSL2 requires relatively recent OpenSCAD

---

## Testing with Guitar Binding Generator

Once BOSL2 is installed, test with the quick test file:

```bash
cd /path/to/bindingstrips
openscad src/quick_test.scad
```

**Expected:**
- Renders in 30-60 seconds
- Shows spiral coil of binding
- No errors in console

**If this works**, you're ready to use all presets!

---

## Alternative: Manual Path Installation

If automatic discovery doesn't work, you can manually specify the path:

### Option 1: Modify Include Statement

Edit `src/guitar_binding.scad` line 11:

```scad
// Change from:
include <BOSL2/std.scad>

// To (use your actual path):
include </full/path/to/BOSL2/std.scad>
```

### Option 2: Add to OPENSCADPATH Environment Variable

#### macOS / Linux (Bash)
Add to `~/.bashrc` or `~/.zshrc`:
```bash
export OPENSCADPATH="/full/path/to/libraries:$OPENSCADPATH"
```

#### Windows
Add to system environment variables:
- Variable name: `OPENSCADPATH`
- Value: `C:\path\to\libraries`

---

## Keeping BOSL2 Updated (Optional)

BOSL2 is actively developed. To update:

### If Downloaded as ZIP:
1. Download latest ZIP from GitHub
2. Replace old BOSL2 folder with new one

### If Cloned with Git:
```bash
cd ~/Documents/OpenSCAD/libraries/BOSL2
git pull
```

**Note:** This project is tested with BOSL2 as of December 2025. Newer versions should remain compatible.

---

## Need Help?

- **BOSL2 Documentation:** https://github.com/BelfrySCAD/BOSL2/wiki
- **OpenSCAD Manual:** https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
- **Project Issues:** If BOSL2 is installed but presets still fail, open an issue with your OpenSCAD version and OS

---

## Next Steps

✅ BOSL2 installed and verified
→ Try rendering: `openscad src/quick_test.scad`
→ Generate your first binding: `./scripts/print_this.sh acoustic_standard`
→ See [START_HERE.md](START_HERE.md) for preset selection guide
