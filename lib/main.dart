import 'package:flutter/material.dart';
import 'constantes.dart';
import 'views/connexion.dart';

void main() {
  runApp(const NoteFlowApp());
}

class NoteFlowApp extends StatelessWidget {
  const NoteFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Couleurs.violetPrincipal,
        scaffoldBackgroundColor: Couleurs.fondEcran,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Couleurs.violetPrincipal,
          secondary: Couleurs.secondaire,
          error: Couleurs.danger,
        ),
        fontFamily: 'Roboto',
      ),
      home: const ConnexionPage(),
    );
  }
}
