# Instagram-Style Professional UI Design Guide

## Overview
This guide ensures all screens follow Instagram's professional, polished design standards with clean UI, proper spacing, and no clutter.

---

## Color Palette

### Primary Colors
- **Primary:** `#6C5CE7` (Purple) - Main brand color for CTAs and highlights
- **Primary Light:** `#8B7ED8` - Hover/secondary states
- **Primary Dark:** `#5A4FCF` - Pressed/active states

### Secondary Colors
- **Secondary:** `#FF6B9D` (Pink) - Accent color for special elements
- **Info/Blue:** `#3B82F6` - Information and interactive elements
- **Success/Green:** `#10B981` - Success states
- **Warning/Orange:** `#F59E0B` - Warning states
- **Error/Red:** `#EF4444` - Error and destructive actions

### Neutral Colors
- **Text Primary:** `#1A1A1A` - Main text
- **Text Secondary:** `#6B7280` - Secondary text
- **Text Tertiary:** `#9CA3AF` - Subtle text
- **Background:** `#FFFFFF` - Main background
- **Background Secondary:** `#FAFAFA` - Card backgrounds
- **Background Tertiary:** `#F5F5F5` - Input backgrounds
- **Border:** `#E5E7EB` - Borders and dividers

---

## Typography

### Font Weights
- **Light:** 300 - Rarely used, premium headings only
- **Regular:** 400 - Body text
- **Medium:** 500 - Subtle emphasis
- **Semi-Bold:** 600 - Primary headings, labels
- **Bold:** 700 - Major headings

### Font Sizes & Line Heights
```
Display Large     32pt | 700 | 1.25x height | -0.5 letter spacing
Display Medium    28pt | 600 | 1.3x height  | -0.25 letter spacing
Display Small     24pt | 600 | 1.35x height |
Headline Large    22pt | 700 | 1.4x height  | -0.25 letter spacing
Headline Medium   20pt | 600 | 1.4x height  |
Headline Small    18pt | 600 | 1.45x height |
Title Large       16pt | 600 | 1.5x height  |
Title Medium      14pt | 600 | 1.5x height  |
Title Small       12pt | 600 | 1.5x height  | 0.1 letter spacing
Body Large        16pt | 400 | 1.5x height  | 0.2 letter spacing
Body Medium       14pt | 400 | 1.5x height  | 0.1 letter spacing
Body Small        12pt | 400 | 1.5x height  | 0.1 letter spacing (secondary text)
Label Large       14pt | 600 | 1.43x height | 0.1 letter spacing
Label Medium      12pt | 600 | 1.33x height | 0.1 letter spacing
Label Small       10pt | 600 | 1.4x height  | 0.1 letter spacing
```

---

## Spacing System (8pt Grid)

### Standard Spacing
```
XS: 4pt   (1 unit)
S:  8pt   (1 unit) - Default padding/margin
M:  12pt  (1.5 units)
L:  16pt  (2 units) - Card padding, main spacing
XL: 24pt  (3 units) - Section padding
XXL: 32pt (4 units) - Large sections
```

### Application
- **Padding:** 16pt for cards, 12pt for internal elements
- **Margins:** 8pt between list items, 16pt between sections
- **Gaps:** 12pt in rows/columns, 16pt for major groups

---

## Shadow System

### Shadow Levels (Elevation)
```
Level 0 (None)        - No shadow
Level 1 (Subtle)      - 2px blur, 0x2 offset - Cards at rest
Level 2 (Small)       - 6px blur, 0x2 offset - Buttons
Level 3 (Medium)      - 8px blur, 0x4 offset - Elevated cards
Level 4 (Large)       - 12px blur, 0x6 offset - Modals
Level 5 (Extra Large) - 16px blur, 0x8 offset - FABs, Popups
```

### Usage Rules
- **Cards:** Use Level 1 shadow only (subtle border)
- **Buttons:** Use Level 2 shadow for emphasis
- **Modals:** Use Level 4 shadow
- **FAB:** Use Level 5 shadow
- **Hover State:** Increase shadow by 1 level

---

## Component Guidelines

### Navigation Bar (Instagram-Style)
- **Height:** 60pt (phone), 72pt (tablet)
- **Background:** `#FFFFFF` with subtle top border
- **Icons:** 24pt, gray when inactive, primary when active
- **Indicator:** Small circular dot below active icon
- **Spacing:** Equal distribution with SVG insets
- **Shadow:** Subtle shadow on top edge (Level 1)

### Post Card
- **Margin Bottom:** 8pt (for stacking)
- **Header:** 16pt padding, profile picture + username + menu
- **Media:** Full width, no border radius (edge to edge)
- **Actions:** 16pt padding, icon buttons in row (like, comment, share, bookmark)
- **Spacing Below Actions:** 12pt to likes count
- **Caption:** 16pt padding, max 3 lines before truncation
- **Comments:** Gray text, clickable "View all comments" link
- **Timestamp:** 12pt gray text, bottom padding 16pt

### Search/Input Fields
- **Height:** 44pt
- **Padding:** 12pt horizontal, 12pt vertical
- **Border Radius:** 12pt
- **Border:** 1pt solid border color, 2pt on focus
- **Background:** Slightly tinted secondary background
- **Icon:** 20pt left/right inset 12pt
- **No Filled Background:** Use outline style primarily

### Buttons (CTA)
- **Elevated Button:** Background color, white text, 12pt padding
- **Outline Button:** Border, no fill, primary text
- **Text Button:** No background, primary text
- **Border Radius:** 12pt minimum
- **Height:** 44pt
- **No Shadows:** Buttons don't use shadows (only on hover)

### Cards
- **Border Radius:** 16pt
- **Border:** 0.5pt solid border color
- **Shadow:** Level 1 only
- **Padding:** 16pt internal
- **No Gradients:** Solid colors only (unless special feature)

### Modal/Bottom Sheet
- **Background:** `#FFFFFF`
- **Border Radius:** 20pt top corners only
- **Shadow:** Level 4 on top
- **Drag Handle:** 40x4pt gray bar at top
- **Padding:** 20pt all sides

### Profile Picture
- **Shape:** Circle
- **Sizes:** 32pt (small), 40pt (medium), 48pt (large)
- **Border:** 2pt white ring around image
- **Gradient:** Use primary gradient as background
- **Shadow:** Level 1 for larger sizes

---

## Interaction & Animation

### Tap Animations
- **Ripple Effect:** 300ms, material ink well style
- **Scale:** 0.96x on press, 1x on release
- **Duration:** 200ms with easeOut curve

### Transitions
- **Page Navigation:** 300ms easeInOut
- **Modal Entry:** 200ms easeInOut from bottom
- **Icon Changes:** 200ms cross-fade
- **Color Changes:** 200ms animated container

### Micro-Interactions
- **Like Button:** 200ms elastic scale (1.0 → 1.2 → 1.0)
- **Like Heart:** 800ms fade out + scale up
- **Bookmark Toggle:** 150ms scale + color change
- **Pull to Refresh:** Standard Material behavior

---

## Grid & Layout

### Responsive Breakpoints
- **Phone:** < 600pt width
- **Tablet:** 600pt - 960pt width
- **Desktop:** > 960pt width

### List Layouts
- **Single Column Feed:** 100% width minus safe area
- **Grid Items:** 2-3 columns depending on screen
- **Horizontal List:** Scrollable with 12pt spacing

### Padding Rules
- **Safe Area Top:** 12pt minimum below status bar
- **Safe Area Bottom:** 12pt minimum above nav bar
- **Horizontal Padding:** 16pt on phone, 24pt on tablet
- **Vertical Padding:** 16pt between sections

---

## States & Feedback

### Disabled State
- **Text Color:** `#D1D5DB` (text-disabled)
- **Background:** `#F5F5F5` (background-tertiary)
- **Opacity:** 0.5 alternative
- **Cursor:** Not-allowed

### Hover State
- **Background:** Slightly darker/lighter than rest state
- **Shadow:** Increase by 1 level
- **Scale:** Slightly larger (1.02x)
- **Duration:** 200ms

### Loading State
- **Spinner:** Primary color, 20pt size
- **Backdrop:** Optional 40% black overlay
- **Text:** "Loading..." in secondary text color
- **Duration:** Indeterminate until complete

### Error State
- **Border:** 1pt error color
- **Text:** Error color below field
- **Icon:** Error icon on right
- **Background:** Error light background (optional)

### Success State
- **Border:** 1pt success color
- **Text:** Success color below field
- **Icon:** Checkmark on right
- **Animation:** 200ms scale pulse

---

## Typography Application

### Headings
- **Page Title:** Display Large (32pt, 700)
- **Section Header:** Headline Large (22pt, 700)
- **Card Title:** Title Large (16pt, 600)
- **List Item Title:** Title Medium (14pt, 600)

### Body Text
- **Description:** Body Medium (14pt, 400)
- **Secondary Info:** Body Small (12pt, 400) in gray
- **Captions:** Caption (12pt, 500) in tertiary gray
- **Links:** Body Medium with underline in primary color

### Buttons & Labels
- **Button Text:** Label Large (14pt, 600) white
- **Tab Label:** Label Medium (12pt, 600) in primary when active
- **Badge:** Label Small (10pt, 600) in white

---

## Do's & Don'ts

### DO
- Use proper color contrast (AA standard minimum)
- Maintain consistent spacing with 8pt grid
- Apply shadows subtly and purposefully
- Use animations for meaningful feedback
- Keep text crisp and readable at all sizes
- Group related items with proper spacing

### DON'T
- Mix more than 3 font styles on one screen
- Use harsh/bright gradients
- Clutter with too many colors
- Add shadows everywhere
- Use animations unnecessarily
- Mix rounded corners (stick to 12pt or 16pt)
- Use different padding values randomly

---

## Implementation Checklist

For each new screen, ensure:

- [ ] Colors from AppColors defined constants
- [ ] Typography using AppTextStyles
- [ ] Spacing on 8pt grid
- [ ] Shadows from AppShadows
- [ ] Proper responsive behavior (phone/tablet)
- [ ] No clutter, clean visual hierarchy
- [ ] Consistent with navigation pattern
- [ ] Touch targets at least 44pt (mobile)
- [ ] Proper contrast ratios
- [ ] Smooth animations (200-300ms)
- [ ] Haptic feedback on interactions
- [ ] Loading states handled
- [ ] Error states displayed clearly
- [ ] Empty states show helpful message

---

## File References

```dart
// Import these in every screen/widget
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/text_styles.dart';

// Use these consistently
AppColors.primary           // Primary brand color
AppColors.textPrimary       // Main text
AppColors.background        // Main background
AppShadows.depthLevel1      // Subtle card shadow
AppShadows.medium           // Elevated elements
AppTextStyles.headlineLarge // 22pt bold heading
AppTextStyles.bodyMedium    // 14pt regular body
```

---

## Example: Professional Post Card Structure

```dart
Container(
  margin: const EdgeInsets.only(bottom: 8),
  decoration: BoxDecoration(
    color: AppColors.surface,
    border: const Border(
      top: BorderSide(color: AppColors.border, width: 0.5),
      bottom: BorderSide(color: AppColors.border, width: 0.5),
    ),
    boxShadow: AppShadows.depthLevel1,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Header: 16pt padding
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Profile picture: circular with gradient
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: AppShadows.small,
              ),
            ),
            const SizedBox(width: 12),
            // Username: 16pt padding
            Text('Username', style: AppTextStyles.titleMedium),
          ],
        ),
      ),
      // Media: full width, edge to edge
      CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
      // Actions: 16pt padding, icon buttons
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Action buttons using Level 1 shadows
          ],
        ),
      ),
      // Caption: 16pt padding
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
          text: TextSpan(
            style: AppTextStyles.bodyMedium,
            children: [
              TextSpan(text: 'Username', style: AppTextStyles.titleMedium),
              TextSpan(text: ' Caption text'),
            ],
          ),
        ),
      ),
    ],
  ),
)
```

---

## Quick Reference: Common Measurements

```
Safe Area Inset:       12pt
Card Padding:          16pt
List Item Height:      56pt-80pt
Divider Height:        0.5pt
Icon Size (standard):  24pt
Icon Size (large):     28pt-32pt
Button Height:         44pt
Input Height:          44pt
NavBar Height:         60pt (phone) / 72pt (tablet)
Status Bar Height:     24pt (variable)
```

---

This guide ensures professional, polished Instagram-like design across all screens with zero clutter and maximum clarity.
