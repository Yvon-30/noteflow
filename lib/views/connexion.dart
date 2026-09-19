import 'package:flutter/material.dart';
import '../constantes.dart';
import 'creer_compte.dart';
import 'liste_notes.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _ctrlIdentifiant = TextEditingController();
  final _ctrlMotDePasse = TextEditingController();
  String? _erreur;

  void _seConnecter() {
    setState(() => _erreur = null);

    if (_ctrlIdentifiant.text.trim().isEmpty ||
        _ctrlMotDePasse.text.trim().isEmpty) {
      setState(() => _erreur = "⚠️ Remplis tous les champs !");
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ListeNotesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Couleurs.fondEcran,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Couleurs.violetPrincipal,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'NoteFlow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Organisez vos idées simplement',
                style: TextStyle(color: Couleurs.texteGris, fontSize: 13),
              ),
              const SizedBox(height: 32),

              // Carte de connexion
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Couleurs.violetPrincipal.withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    if (_erreur != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(_erreur!, style: const TextStyle(color: Colors.red)),
                      ),

                    TextField(
                      controller: _ctrlIdentifiant,
                      decoration: InputDecoration(
                        labelText: 'Identifiant',
                        labelStyle: const TextStyle(fontSize: 13),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Couleurs.violetPrincipal.withOpacity(0.5)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _ctrlMotDePasse,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        labelStyle: const TextStyle(fontSize: 13),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Couleurs.violetPrincipal.withOpacity(0.5)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _seConnecter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Couleurs.violetPrincipal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CreerComptePage()),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 13),
                          children: const [
                            TextSpan(text: 'Première connexion ? '),
                            TextSpan(
                              text: 'Créer un compte',
                              style: TextStyle(
                                color: Couleurs.violetPrincipal,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
