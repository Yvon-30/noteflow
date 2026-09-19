import 'package:flutter/material.dart';
import '../constantes.dart';
import '../modele/note.dart';
import '../services/db_service.dart';

class NoteEditionPage extends StatefulWidget {
  final Note? note;

  const NoteEditionPage({super.key, this.note});

  @override
  State<NoteEditionPage> createState() => _NoteEditionPageState();
}

class _NoteEditionPageState extends State<NoteEditionPage> {
  final DBService _db = DBService.instance;
  final _ctrlTitre = TextEditingController();
  final _ctrlContenu = TextEditingController();
  bool _sauvegardeEnCours = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _ctrlTitre.text = widget.note!.titre;
      _ctrlContenu.text = widget.note!.contenu;
    }
  }

  Future<void> _enregistrer() async {
    final titre = _ctrlTitre.text.trim();
    final contenu = _ctrlContenu.text.trim();

    if (titre.isEmpty || contenu.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Remplis le titre et le contenu !'), backgroundColor: Couleurs.danger),
      );
      return;
    }

    setState(() => _sauvegardeEnCours = true);

    if (widget.note != null) {
      await _db.modifier(Note(
        id: widget.note!.id,
        titre: titre,
        contenu: contenu,
        dateCreation: widget.note!.dateCreation,
      ));
    } else {
      await _db.ajouter(Note(titre: titre, contenu: contenu));
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final estModification = widget.note != null;

    return Scaffold(
      backgroundColor: Couleurs.fondEcran,
      appBar: AppBar(
        backgroundColor: Couleurs.violetPrincipal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          estModification ? 'Modifier la note' : 'Nouvelle note',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Titre de la note',
              style: TextStyle(fontWeight: FontWeight.bold, color: Couleurs.textePrincipal),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrlTitre,
              decoration: InputDecoration(
                hintText: 'Titre de la note',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Couleurs.violetPrincipal.withOpacity(0.5)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Contenu',
              style: TextStyle(fontWeight: FontWeight.bold, color: Couleurs.textePrincipal),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrlContenu,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Écrivez votre note ici...',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Couleurs.violetPrincipal.withOpacity(0.5)),
                ),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sauvegardeEnCours ? null : _enregistrer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Couleurs.violetPrincipal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _sauvegardeEnCours
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        '💾 ENREGISTRER',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Couleurs.violetPrincipal),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'ANNULER',
                  style: TextStyle(color: Couleurs.violetPrincipal, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
