import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// "Holo Noir + Energia" design system (user-approved hybrid, 2026-07-14):
// deep graphite stage so card art pops, iridescent holo gradient reserved for
// actions/prices/brand, and TCG energy-type colors used as information on
// chips and filters.
// ---------------------------------------------------------------------------

const holoCyan = Color(0xFF46E3FF);
const holoViolet = Color(0xFFB06BFF);
const holoPink = Color(0xFFFF5FA8);
const holoGold = Color(0xFFFFD34E);

const holoGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [holoCyan, holoViolet, holoPink, holoGold],
);

const surfaceDeep = Color(0xFF0D0D13);
const surfaceCard = Color(0xFF17171F);
const surfaceRaised = Color(0xFF1E1E29);
const inkBright = Color(0xFFEEF0F6);
const inkDim = Color(0xFF9C9AA6);

/// Energy-type colors (Energia Viva): information, not decoration — the user
/// reads the app the way they read the game.
const energyColors = <String, Color>{
  'Fire': Color(0xFFFF9838),
  'Water': Color(0xFF64C9FF),
  'Lightning': Color(0xFFFFE14D),
  'Grass': Color(0xFF8FE08F),
  'Psychic': Color(0xFFD3A6FF),
  'Fighting': Color(0xFFE58B5A),
  'Darkness': Color(0xFF8A8FA8),
  'Metal': Color(0xFFB8C4CE),
  'Colorless': Color(0xFFE8E6DA),
  'Dragon': Color(0xFFD4B04A),
  'Fairy': Color(0xFFFFB3C7),
};

/// Rarities beyond Common/Uncommon get the holo treatment in the UI.
bool isHoloRarity(String? rarity) {
  if (rarity == null) return false;
  return rarity != 'Common' && rarity != 'Uncommon';
}

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: surfaceDeep,
  colorScheme:
      ColorScheme.fromSeed(seedColor: holoViolet, brightness: Brightness.dark).copyWith(
    primary: holoCyan,
    secondary: holoViolet,
    tertiary: holoGold,
    surface: surfaceDeep,
    surfaceContainerHighest: surfaceRaised,
    onSurface: inkBright,
    onSurfaceVariant: inkDim,
    outline: const Color(0xFF34343F),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: surfaceDeep,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.3,
      color: inkBright,
    ),
  ),
  cardTheme: CardThemeData(
    color: surfaceCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Color(0x1FFFFFFF)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0x14FFFFFF),
    hintStyle: const TextStyle(color: inkDim),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0x1FFFFFFF)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0x1FFFFFFF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: holoCyan, width: 1.4),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0x14FFFFFF),
    side: const BorderSide(color: Color(0x1FFFFFFF)),
    labelStyle: const TextStyle(color: inkBright, fontSize: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: surfaceRaised,
    contentTextStyle: TextStyle(color: inkBright),
    behavior: SnackBarBehavior.floating,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: holoCyan,
    linearTrackColor: Color(0x22FFFFFF),
  ),
);
