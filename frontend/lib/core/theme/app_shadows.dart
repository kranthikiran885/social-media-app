import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  // Subtle shadow for cards and containers
  static const BoxShadow subtle = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  // Small elevation shadow
  static const BoxShadow small = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  // Medium elevation shadow
  static const BoxShadow medium = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  // Large elevation shadow
  static const BoxShadow large = BoxShadow(
    color: Color(0x28000000),
    blurRadius: 12,
    offset: Offset(0, 6),
  );

  // Extra large elevation shadow
  static const BoxShadow extraLarge = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  // Shadow lists for decoration
  static const List<BoxShadow> cardShadow = [subtle];
  
  static const List<BoxShadow> buttonShadow = [small];
  
  static const List<BoxShadow> elevatedCardShadow = [medium];
  
  static const List<BoxShadow> modalShadow = [large];
  
  static const List<BoxShadow> floatingActionButtonShadow = [extraLarge];

  // Multi-layer shadows for depth
  static const List<BoxShadow> depthLevel1 = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> depthLevel2 = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> depthLevel3 = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> depthLevel4 = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 3),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  // Interactive shadows
  static const List<BoxShadow> interactiveFocus = [
    BoxShadow(
      color: Color.fromRGBO(108, 92, 231, 0.3),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> interactiveHover = [
    BoxShadow(
      color: Color(0x28000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  // Colored shadows
  static List<BoxShadow> coloredShadow(Color color, {double opacity = 0.3}) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ];
  }

  // Glow effect shadow
  static List<BoxShadow> glowShadow({
    required Color color,
    double blurRadius = 16,
    double intensity = 0.4,
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(intensity),
        blurRadius: blurRadius,
        spreadRadius: 0,
      ),
    ];
  }

  // Inset shadow (for borders/frames)
  static List<BoxShadow> insetShadow({
    Color color = const Color(0x14000000),
    double blurRadius = 4,
  }) {
    return [
      BoxShadow(
        color: color,
        blurRadius: blurRadius,
        offset: const Offset(0, 1),
        inset: true,
      ),
    ];
  }
}

// Material elevation mapping
class AppElevation {
  static const double none = 0;
  static const double level1 = 1;
  static const double level2 = 3;
  static const double level3 = 6;
  static const double level4 = 8;
  static const double level5 = 12;

  // Get shadow for elevation level
  static List<BoxShadow> getShadowForElevation(double elevation) {
    if (elevation <= 0) return [];
    if (elevation <= 1) return AppShadows.depthLevel1;
    if (elevation <= 3) return AppShadows.depthLevel2;
    if (elevation <= 6) return AppShadows.depthLevel3;
    if (elevation <= 8) return AppShadows.depthLevel4;
    return AppShadows.floatingActionButtonShadow;
  }
}
