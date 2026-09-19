import 'package:flutter/material.dart';
import '../constantes.dart';
import 'liste_notes.dart';

class CreerComptePage extends StatefulWidget {
  const CreerComptePage({super.key});

  @override
  State<CreerComptePage> createState() => _CreerComptePageState();
}

class _CreerComptePageState extends State<CreerComptePage> {
  final _ctrlIdentifiant = TextEditingController();
  final _ctrlMotDePasse = TextEditingController();
  final _ctrlConfirmer = TextEditingController();
  String? _erreur;

  void _valider() {
    setState(() => _erreur = null);

    if (_ctrlIdentifiant.text.trim().isEmpty ||
        _ctrlMotDePasse.text.trim().isEmpty ||
        _ctrlConfirmer.text.trim().isEmpty) {
      setState(() => _erreur = "⚠️ Remplis TOUS les champs !");
      return;
    }

    if (_ctrlMotDePasse.text != _ctrlConfirmer.text) {
      setState(() => _erreur = "⚠️ Les mots de passe ne correspondent pas !");
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _ctrlConfirmer,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
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
                        onPressed: _valider,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Couleurs.violetPrincipal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Valider',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 13),
                          children: const [
                            TextSpan(text: 'Déjà un compte ? '),
                            TextSpan(
                              text: 'Se connecter',
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
