import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/note.dart';

class DBService {
  static final DBService instance = DBService._init();
  static Database? _db;

  DBService._init();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _ouvrirBase();
    return _db!;
  }

  Future<Database> _ouvrirBase() async {
    final chemin = await getDatabasesPath();
    return await openDatabase(
      join(chemin, 'noteflow.db'),
      version: 1,
      onCreate: _creerTables,
    );
  }

  Future _creerTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        contenu TEXT NOT NULL,
        dateCreation TEXT NOT NULL
      )
    ''');
  }

  Future<int> ajouter(Note note) async {
    final base = await db;
    return await base.insert('notes', note.toMap());
  }

  Future<List<Note>> listerTout({String recherche = ''}) async {
    final base = await db;
    final liste = await base.query(
      'notes',
      orderBy: 'dateCreation DESC',
    );
    final toutes = liste.map((map) => Note.fromMap(map)).toList();

    if (recherche.trim().isEmpty) return toutes;
    return toutes.where((note) {
      final terme = recherche.toLowerCase();
      return note.titre.toLowerCase().contains(terme) ||
             note.contenu.toLowerCase().contains(terme);
    }).toList();
  }

  Future<int> modifier(Note note) async {
    final base = await db;
    return await base.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> supprimer(int id) async {
    final base = await db;
    return await base.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
