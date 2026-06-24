# Design System Quick Reference

## TL;DR - Essentials Only

### Colors
```dart
// Always use these, never hardcode colors
AppColors.primary          // #6C5CE7 Purple (buttons, highlights)
AppColors.textPrimary      // #1A1A1A Dark (main text)
AppColors.background       // #FFFFFF White (backgrounds)
AppColors.border           // #E5E7EB Light gray (borders)
AppColors.error            // #EF4444 Red (errors)
AppColors.success          // #10B981 Green (success)
```

### Typography
```dart
// Always use these for text
AppTextStyles.headlineSmall     // 18pt bold, dark
AppTextStyles.titleMedium       // 14pt bold
AppTextStyles.bodyMedium        // 14pt regular
AppTextStyles.bodySmall         // 12pt regular, gray
AppTextStyles.labelSmall        // 10pt bold, light gray
```

### Spacing
```
Use 8pt, 12pt, 16pt, 24pt, 32pt
Never use random numbers like 15pt, 18pt, 22pt
```

### Shadows
```dart
AppShadows.depthLevel1          // Cards
AppShadows.medium               // Buttons
AppShadows.small                // Hover state
```

---

## Component Quick Use

### AppBar
```dart
appBar: InstagramAppBar(
  title: 'Page Title',
  showBackButton: true,
),
```

### Card
```dart
AppCard(
  padding: const EdgeInsets.all(16),
  child: Text('Content'),
)
```

### Button
```dart
AppButton(
  label: 'Click Me',
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
  ),
)
```

### TextField
```dart
AppTextField(
  hintText: 'Enter text',
  prefixIcon: Icons.search,
)
```

### Profile Picture
```dart
ProfilePicture(
  imageUrl: 'https://...',
  size: 40,
)
```

### Divider
```dart
AppDivider()  // Professional divider with correct spacing
```

---

## Screen Padding Rules

| Element | Padding |
|---------|---------|
| Screen edges | 16pt horizontal |
| Card padding | 16pt all sides |
| List items | 12pt vertical, 16pt horizontal |
| Section gaps | 24pt between sections |
| Status bar | 12pt minimum |
| Nav bar | 12pt minimum |

---

## Font Sizes

| Use Case | Size | Weight |
|----------|------|--------|
| Page title | 18pt | 600 |
| Section header | 16pt | 600 |
| Body text | 14pt | 400 |
| Secondary text | 12pt | 400 |
| Small labels | 10pt | 600 |

---

## Spacing Quick Reference

```
XS: 4pt (internal spacing only)
S: 8pt (between items)
M: 12pt (moderate spacing)
L: 16pt (standard padding)
XL: 24pt (section gaps)
XXL: 32pt (large sections)
```

**Golden Rule:** Always use multiples of 4pt

---

## Icon Sizes

```
Small:  16pt
Medium: 20pt (most common)
Large:  24pt
XL:     28-32pt
```

---

## Color Quick Reference

| Usage | Color | Hex |
|-------|-------|-----|
| Primary Actions | AppColors.primary | #6C5CE7 |
| Main Text | AppColors.textPrimary | #1A1A1A |
| Secondary Text | AppColors.textSecondary | #6B7280 |
| Light Text | AppColors.textTertiary | #9CA3AF |
| Background | AppColors.background | #FFFFFF |
| Card Background | AppColors.surface | #FFFFFF |
| Borders | AppColors.border | #E5E7EB |
| Errors | AppColors.error | #EF4444 |
| Success | AppColors.success | #10B981 |

---

## Component Heights

```
Button:              44pt
TextField:           44pt
ListTile:            56pt
BottomNav:           60pt (phone) / 72pt (tablet)
AppBar:              56pt
Card Header:         60-80pt
Profile Picture:     32-80pt (varies)
Input Field:         44pt
Spacing after card:  8pt
```

---

## Animation Durations

```
Quick interaction:   150ms
Standard action:     200ms
Page transition:     300ms
Long feedback:       500-800ms
```

Use `Curves.easeInOut` for most animations

---

## Shadow Levels

```
None/Subtle:    2pt blur, 0x2 offset    (cards)
Small:          6pt blur, 0x2 offset    (buttons)
Medium:         8pt blur, 0x4 offset    (elevated)
Large:          12pt blur, 0x6 offset   (modals)
ExtraLarge:     16pt blur, 0x8 offset   (FABs)
```

---

## DO's

✓ Use AppColors constants  
✓ Use AppTextStyles  
✓ Use 8pt grid for spacing  
✓ Use AppShadows  
✓ Use app_components widgets  
✓ 16pt card padding  
✓ 44pt touch targets  
✓ Smooth 200-300ms animations  
✓ Professional border-radius (12-16pt)  

---

## DON'Ts

✗ Hardcode colors  
✗ Random spacing (15pt, 22pt, 18pt, etc)  
✗ Mix font families  
✗ Shadows everywhere  
✗ Clutter UI with too many elements  
✗ Use bright gradients  
✗ Random border-radius values  
✗ Skip haptic feedback  
✗ Instant state changes (no animation)  

---

## Import Template (Copy & Paste)

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_components.dart';
```

---

## File Locations

- **Colors:** `lib/core/theme/app_colors.dart`
- **Typography:** `lib/core/theme/text_styles.dart`
- **Shadows:** `lib/core/theme/app_shadows.dart`
- **Components:** `lib/core/widgets/app_components.dart`
- **Theme:** `lib/core/theme/app_theme.dart`

---

## Most Common Mistakes to Avoid

1. **Mixing padding values:** Use 8pt multiples only
2. **Random colors:** Always use AppColors
3. **Inconsistent text:** Always use AppTextStyles
4. **No shadows:** Use AppShadows appropriately
5. **Clutter:** Keep UI clean, remove unnecessary elements
6. **Tiny touch targets:** Minimum 44pt for buttons
7. **Hard-to-read text:** Use proper contrast and sizing
8. **Instant changes:** Add smooth animations
9. **Different button styles:** Use consistent component styling
10. **Inconsistent spacing:** Follow 8pt grid religiously

---

## Professional Standards Applied

- **Design System:** Instagram-inspired professional UI
- **Accessibility:** WCAG AA contrast standards
- **Responsiveness:** Works on phone, tablet, and desktop
- **Animation:** Smooth 60fps transitions
- **Colors:** Carefully chosen palette with proper hierarchy
- **Typography:** Professional font sizing and weights
- **Spacing:** Precise 8pt grid system
- **Shadows:** Subtle depth hierarchy
- **Components:** Reusable, consistent patterns
- **Zero Clutter:** Only essential UI elements shown

---

## See Also

- `INSTAGRAM_UI_STYLE_GUIDE.md` - Complete design guide
- `PROFESSIONAL_UI_IMPLEMENTATION_GUIDE.md` - Code patterns for all screens
- `lib/core/widgets/app_components.dart` - Reusable components

---

## Checklist for New Screen

Add this to every new screen:

```dart
// 1. Import all three
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/app_shadows.dart';

// 2. Use these exclusively
- AppColors.* for all colors
- AppTextStyles.* for all text
- AppShadows.* for all shadows
- app_components for buttons, cards, etc.

// 3. Follow these rules
- 16pt card padding
- 8pt grid spacing
- 12-16pt border radius
- 44pt minimum touch targets
- 200-300ms animations
- Proper visual hierarchy

// 4. Final check
- [ ] No hardcoded colors
- [ ] No random spacing
- [ ] Consistent typography
- [ ] Professional appearance
- [ ] Clean, no clutter
```

---

**Remember:** Professional design is about consistency, clarity, and zero clutter. Follow this system religiously across all screens for a polished Instagram-like experience.
