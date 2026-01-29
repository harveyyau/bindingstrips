# How to Measure Your Guitar for Binding

Accurate measurement is key to printing the right amount of binding. This guide will walk you through the process.

## What You Need

- **Flexible measuring tape** (sewing/tailor tape works great)
- **Paper and pen** (to record your measurement)
- **Calculator** (or use the length_calculator.sh script)

---

## Where to Measure

### For Body Binding (Most Common)

Measure around the **side edge** of the guitar body where the binding will be installed.

```
        [Guitar Body - Top View]
        
            ╱‾‾‾‾‾‾‾‾‾‾╲
          ╱              ╲
         │                │ ← Measure HERE
         │   Soundhole    │   (around the edge)
         │                │
          ╲              ╱
            ╲__________╱
                 ↑
            Measure around this edge
```

**Important:** 
- Measure on the **side edge** where binding sits, NOT on the top surface
- Start and end at the same point (e.g., at the neck joint)
- Keep the tape snug but not stretched

### For Rosette Purfling (Classical Guitars)

Measure around the **soundhole perimeter** where decorative purfling will go.

---

## Step-by-Step Instructions

### 1. Position the Tape

- Place the end of the tape at the neck joint (where neck meets body)
- This gives you a clear start/end reference point

### 2. Follow the Contour

- Run the tape around the entire body edge
- Follow curves carefully - don't pull the tape tight across curves
- Keep the tape flat against the side edge

### 3. Meet Back at the Start

- Bring the tape back to your starting point
- Note where the tape overlaps
- Record this measurement in **millimeters**

### 4. Double-Check

- Measure a second time to verify
- Measurements should be within 10-20mm of each other
- If they differ significantly, measure again

---

## Apply Safety Margin

**Always add 15% to your measured length** for:
- Waste during fitting
- Trimming to final length
- Installation mistakes
- A little extra "just in case"

### Manual Calculation

```
Measured perimeter: ______ mm
× 1.15 (15% margin)
= ______ mm needed
```

**Example:**
```
Measured: 890mm
× 1.15
= 1024mm needed → Use acoustic_standard (1000mm)
```

### Or Use the Calculator Script

```bash
cd scripts
./length_calculator.sh 890
```

The script automatically calculates and recommends the right preset.

---

## Common Guitar Perimeter Ranges

Use these as rough guides (actual measurements vary by manufacturer):

| Guitar Type | Typical Perimeter | With 15% Margin | Recommended Preset |
|-------------|-------------------|-----------------|-------------------|
| **Mandolin** | 350-450mm | 400-520mm | mandolin_binding |
| **Concert Ukulele** | 300-350mm | 350-400mm | mandolin_binding |
| **Tenor Ukulele** | 400-450mm | 460-520mm | mandolin_binding |
| **Stratocaster** | 650-750mm | 750-860mm | electric_standard |
| **Telecaster** | 650-700mm | 750-805mm | electric_standard |
| **Les Paul** | 700-800mm | 805-920mm | electric_standard |
| **SG** | 650-750mm | 750-860mm | electric_standard |
| **Dreadnought** | 850-950mm | 980-1090mm | acoustic_standard |
| **OM / 000** | 800-900mm | 920-1035mm | acoustic_standard |
| **Grand Auditorium** | 850-950mm | 980-1090mm | acoustic_standard |
| **Jumbo** | 950-1100mm | 1090-1265mm | acoustic_jumbo |
| **Grand Jumbo** | 1000-1150mm | 1150-1320mm | acoustic_jumbo |

**Note:** These are estimates. Always measure your specific guitar!

---

## Common Mistakes to Avoid

### ❌ Measuring on the Top Surface

**Wrong:** Placing tape flat across the top of the guitar
- This measures the wrong dimension

**Right:** Tape runs along the **side edge** where binding actually sits

### ❌ Pulling Tape Taut

**Wrong:** Stretching the tape tight across curves
- This underestimates the actual perimeter

**Right:** Let the tape follow the natural contour loosely

### ❌ Forgetting Safety Margin

**Wrong:** Printing exactly the measured length
- No room for mistakes or waste

**Right:** Always add 15% (measure × 1.15)

### ❌ Using Inches Instead of Millimeters

**Wrong:** Measuring in inches
- The presets are defined in millimeters

**Right:** Use millimeters (most measuring tapes have both)

---

## What If My Measurement Falls Between Presets?

**Always round UP to the next preset.**

Example:
- Measured: 920mm
- With 15% margin: 1058mm
- acoustic_standard provides 1000mm ← Too short!
- acoustic_jumbo provides 1200mm ← Use this one ✓

**Better to have extra than run short!**

---

## Need Help?

- **Preset recommendation:** Use `./length_calculator.sh <your_measurement>`
- **Print preparation:** See [PRINT_SUCCESS_CHECKLIST.md](PRINT_SUCCESS_CHECKLIST.md)
- **Issues during measurement:** Ask in the project's discussions/issues
