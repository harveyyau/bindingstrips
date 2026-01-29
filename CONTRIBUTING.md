# Contributing to Guitar Binding Generator

Thank you for your interest in contributing! This project welcomes contributions from the community.

---

## Ways to Contribute

### 1. Report Issues

Found a bug or have a feature request?

- **Check existing issues** first to avoid duplicates
- **Open a new issue** with:
  - Clear description of the problem
  - Steps to reproduce (for bugs)
  - OpenSCAD version and OS
  - Photos of failed prints (if applicable)
  - Expected vs. actual behavior

### 2. Improve Documentation

Documentation is crucial for guitar builders who may not be familiar with OpenSCAD.

**What helps:**
- Clarifying confusing sections
- Adding photos of successful prints
- Better measurement diagrams
- Additional troubleshooting tips
- Translations to other languages

### 3. Create New Presets

Have a unique guitar or instrument? Create a preset!

**Requirements:**
- Must include comprehensive header documentation (see existing presets)
- Test print and validate dimensions
- Include print time and filament estimates
- Photo of successful print (ideally installed on guitar)

**Preset template:**
```scad
// presets/my_instrument.scad
/*
  [INSTRUMENT NAME] BINDING
  
  For: [Specific instruments this works for]
  Typical perimeter: [Range in mm]
  This preset produces: [Length]mm usable length
  
  Print time: ~[X] hours
  Filament needed: ~[Y]g ABS
  
  Dimensions: [W]mm × [H]mm
  [Additional notes]
*/

include <../src/guitar_binding.scad>

// Override parameters
strip_length_mm = ...;
// etc.
```

### 4. Submit Code Improvements

**Before submitting:**
- Test with multiple presets
- Run existing presets to ensure no regression
- Follow existing code style
- Update documentation if behavior changes

**Code style:**
- Clear variable names
- Comments explaining non-obvious logic
- Consistent indentation (spaces, not tabs in .scad)
- Validation assertions for critical constraints

---

## Development Workflow

### Setup

```bash
# Clone repository
git clone https://github.com/yourusername/bindingstrips.git
cd bindingstrips

# Install BOSL2 (see docs/BOSL2_SETUP.md)

# Test basic functionality
openscad src/quick_test.scad
```

### Making Changes

```bash
# Create feature branch
git checkout -b feature/my-improvement

# Make changes
# ... edit files ...

# Test changes
./scripts/print_this.sh acoustic_standard

# Commit with clear message
git add .
git commit -m "Add: Brief description of changes"

# Push branch
git push origin feature/my-improvement

# Open pull request on GitHub
```

### Testing Checklist

Before submitting PR:

- [ ] All existing presets still render without errors
- [ ] Quick test renders in < 60 seconds
- [ ] Export scripts work correctly
- [ ] Python validation scripts pass (if modified)
- [ ] Documentation updated (if applicable)
- [ ] No new linter errors introduced

---

## Pull Request Guidelines

### Title Format

- `Add: <feature>` - New functionality
- `Fix: <issue>` - Bug fixes
- `Docs: <topic>` - Documentation only
- `Refactor: <component>` - Code improvements (no behavior change)
- `Preset: <name>` - New preset addition

### PR Description Should Include

- **What:** Clear description of changes
- **Why:** Motivation or problem being solved
- **How:** Brief technical approach (for code changes)
- **Testing:** What you tested and results
- **Photos:** If relevant (especially for new presets)

### Example PR Description

```markdown
## Add: Baritone guitar preset

**What:**
New preset for baritone guitars with 27" scale length.

**Why:**
Baritone guitars have longer bodies and need ~1100mm binding.

**Testing:**
- Rendered successfully in 4 minutes
- Test printed 300mm sample: fits channel perfectly
- Full print completed: 1100mm usable length

**Estimated specs:**
- Print time: ~5 hours
- Filament: ~45g ABS
- Tested on: Ibanez RGIB6
```

---

## Code Review Process

1. **Automated checks:** Lint and basic validation (if implemented)
2. **Manual review:** Maintainers review code and documentation
3. **Testing:** May request test prints or additional validation
4. **Feedback:** Constructive suggestions for improvements
5. **Approval:** Once all checks pass and feedback addressed
6. **Merge:** Integrated into main branch

**Timeline:** Most PRs reviewed within 2-7 days.

---

## Preset Contribution Checklist

Before submitting a new preset:

- [ ] Header documentation complete and clear
- [ ] Parameters validated (assertions pass)
- [ ] Test printed successfully (photo attached)
- [ ] Dimensional accuracy verified with calipers
- [ ] Print time and filament estimates accurate
- [ ] Works with existing export scripts
- [ ] Follows naming convention: `[instrument]_[variant].scad`

---

## Documentation Style Guide

### Markdown Files

- Use clear section headers (`##`, `###`)
- Include examples where helpful
- Code blocks with language tags: ```bash, ```scad, ```python
- Tables for parameter references
- Links to related docs

### Code Comments

```scad
// Brief single-line comments for obvious things

/*
  Multi-line comments for:
  - Complex algorithms
  - Important constraints
  - User-facing documentation
*/

// Inline comments explain WHY, not WHAT
spiral_pitch_mm = 8.0;  // Must be ≥ width + clearance (prevents fusing)
```

### Commit Messages

- First line: Brief summary (50 chars or less)
- Blank line
- Detailed explanation if needed
- Reference issues: `Fixes #123` or `See #456`

---

## Questions?

- **Before coding:** Open a discussion to propose major changes
- **During development:** Comment on your PR with questions
- **General help:** Open an issue tagged "question"

---

## Recognition

Contributors will be:
- Listed in project README
- Acknowledged in release notes
- Credited in preset headers (if applicable)

---

## Code of Conduct

**Be respectful and constructive:**
- Welcoming to beginners (many users are guitar builders, not programmers!)
- Constructive feedback
- Assume good intentions
- Focus on helping users succeed

**Not acceptable:**
- Harassment or discrimination
- Dismissive or condescending comments
- Spam or off-topic discussions

---

## License

By contributing, you agree that your contributions will be licensed under the project's MIT License.

---

## Thank You!

Every contribution helps make this tool better for the guitar building community. Whether it's fixing a typo, adding a preset, or improving the core algorithms - thank you for your help!
