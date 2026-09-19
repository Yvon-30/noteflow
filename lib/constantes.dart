import 'package:flutter/material.dart';

class Couleurs {
  // Palette NoteFlow — d'après ta charte
  static const principale = Color(0xFF6A1B9A);        // Violet foncé
  static const secondaire = Color(0xFF9C27B0);        // Violet moyen
  static const accent = Color(0xFFE1BEE7);            // Violet clair
  static const fond = Color(0xFFFAFAFA);              // Blanc cassé
  static const carte = Color(0xFFF3E5F5);            // Violet très clair
  static const textePrincipal = Color(0xFF1A1A1A);    // Noir
  static const texteSecondaire = Color(0xFF666666);   // Gris
  static const danger = Color(0xFFEF4444);             // Rouge
  static const succes = Color(0xFF22C55E);             // Vert

  // Alias pour la clarté du code
  static const violetPrincipal = principale;
  static const violetFonce = principale;
  static const fondEcran = fond;
  static const fondCarte = carte;
  static const texteGris = texteSecondaire;
  static const texteGrisClair = Color(0xFF9E9E9E);    // Complément
  static const rougeSuppression = danger;
  static const orangeAttention = Color(0xFFFF9800);   // Complément
}
