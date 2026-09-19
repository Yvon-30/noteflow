class Note {
  final int? id;
  final String titre;
  final String contenu;
  final DateTime dateCreation;

  Note({
    this.id,
    required this.titre,
    required this.contenu,
    DateTime? dateCreation,
  }) : dateCreation = dateCreation ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'contenu': contenu,
      'dateCreation': dateCreation.toIso8601String(),
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      titre: map['titre'],
      contenu: map['contenu'],
      dateCreation: DateTime.parse(map['dateCreation']),
    );
  }

  String getDateFormatee() {
    return '${dateCreation.day} ${_moisLettre(dateCreation.month)} ${dateCreation.year}';
  }

  String _moisLettre(int numero) {
    const mois = ['', 'janv', 'févr', 'mars', 'avr', 'mai', 'juin', 'juil', 'août', 'sept', 'oct', 'nov', 'déc'];
    return mois[numero];
  }

  String apercu([int maxCaracteres = 40]) {
    if (contenu.length <= maxCaracteres) return contenu;
    return '${contenu.substring(0, maxCaracteres)}...';
  }
}
