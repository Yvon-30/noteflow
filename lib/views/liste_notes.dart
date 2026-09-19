import 'package:flutter/material.dart';
import '../constantes.dart';
import '../modele/note.dart';
import '../services/db_service.dart';
import 'note_edition.dart';
import 'confirmation_suppression.dart';

class ListeNotesPage extends StatefulWidget {
  const ListeNotesPage({super.key});

  @override
  State<ListeNotesPage> createState() => _ListeNotesPageState();
}

class _ListeNotesPageState extends State<ListeNotesPage> {
  final DBService _db = DBService.instance;
  List<Note> _notes = [];
  String _recherche = '';
  bool _chargement = true;

  @override
  void initState() {
    super.initState();
    _chargerNotes();
  }

  Future<void> _chargerNotes() async {
    setState(() => _chargement = true);
    final liste = await _db.listerTout(recherche: _recherche);
    setState(() {
      _notes = liste;
      _chargement = false;
    });
  }

  Future<void> _supprimerNote(Note note) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmationSuppression(note: note),
    );
    if (confirme == true) {
      await _db.supprimer(note.id!);
      await _chargerNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Couleurs.fondEcran,
      appBar: AppBar(
        backgroundColor: Couleurs.violetPrincipal,
        title: const Text(
          'Mes Notes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Couleurs.violetPrincipal,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteEditionPage()),
          );
          _chargerNotes();
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: _chargement
          ? const Center(child: CircularProgressIndicator(color: Couleurs.violetPrincipal))
          : Column(
              children: [
                // Barre de recherche
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher une note...',
                      hintStyle: const TextStyle(color: Couleurs.texteGris),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (valeur) {
                      setState(() => _recherche = valeur);
                      _chargerNotes();
                    },
                  ),
                ),

                // Liste ou vide
                Expanded(
                  child: _notes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.note, size: 64, color: Couleurs.texteGrisClair),
                              SizedBox(height: 16),
                              Text(
                                'Tu n\'as pas encore de note',
                                style: TextStyle(color: Couleurs.texteGris, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Appuie sur + pour en créer une',
                                style: TextStyle(color: Couleurs.texteGrisClair, fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _notes.length,
                          itemBuilder: (_, index) {
                            final note = _notes[index];
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NoteEditionPage(note: note),
                                  ),
                                );
                                _chargerNotes();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Couleurs.fondCarte,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.titre,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Couleurs.textePrincipal,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          note.apercu(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Couleurs.texteGris,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 12),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            note.getDateFormatee(),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Couleurs.texteGrisClair,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () => _supprimerNote(note),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Couleurs.danger,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
