import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/compromisso.dart';
import '../model/usuario.dart';

class BancoDados {
  static Database? _banco;

  static Future<Database> banco() async {
    if (_banco != null) return _banco!;

    String pasta = await getDatabasesPath();
    String caminho = join(pasta, 'agendaapp.db');

    _banco = await openDatabase(
      caminho,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: criarBanco,
    );

    return _banco!;
  }

  static Future<void> criarBanco(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha TEXT NOT NULL,
        aceita_emails INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE compromissos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT NOT NULL,
        data TEXT NOT NULL,
        usuario_id INTEGER NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
      )
    ''');
  }

  static Future<bool> emailExiste(String email) async {
    Database db = await banco();
    final dados = await db.query(
      'usuarios',
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email.trim().toLowerCase()],
      limit: 1,
    );
    return dados.isNotEmpty;
  }

  static Future<Usuario?> inserirUsuario(Usuario usuario, String senha) async {
    if (await emailExiste(usuario.email)) return null;

    Database db = await banco();
    final dados = usuario.toMap();
    dados['senha'] = senha;

    final id = await db.insert('usuarios', dados);

    return Usuario(
      id: id,
      nome: usuario.nome,
      email: usuario.email,
      aceitaEmails: usuario.aceitaEmails,
    );
  }

  static Future<Usuario?> autenticar(String email, String senha) async {
    Database db = await banco();

    final dados = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email.trim().toLowerCase(), senha],
      limit: 1,
    );

    return dados.isEmpty ? null : Usuario.fromMap(dados.first);
  }

  static Future<int> atualizarUsuario(Usuario usuario) async {
    if (usuario.id == null) throw ArgumentError('Usuário sem ID.');

    Database db = await banco();

    return db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  static Future<int> excluirUsuario(int usuarioId) async {
    Database db = await banco();

    return db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [usuarioId],
    );
  }

  static Future<int> inserirCompromisso(Compromisso compromisso) async {
    Database db = await banco();
    return db.insert('compromissos', compromisso.toMap());
  }

  static Future<List<Compromisso>> listarCompromissos(int usuarioId) async {
    Database db = await banco();

    final dados = await db.query(
      'compromissos',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );

    return dados.map(Compromisso.fromMap).toList();
  }

  static Future<Compromisso?> buscarCompromisso(int id, int usuarioId) async {
    Database db = await banco();

    final dados = await db.query(
      'compromissos',
      where: 'id = ? AND usuario_id = ?',
      whereArgs: [id, usuarioId],
      limit: 1,
    );

    return dados.isEmpty ? null : Compromisso.fromMap(dados.first);
  }

  static Future<int> atualizarCompromisso(Compromisso compromisso) async {
    if (compromisso.id == null) {
      throw ArgumentError('Compromisso sem ID.');
    }

    Database db = await banco();

    return db.update(
      'compromissos',
      compromisso.toMap(),
      where: 'id = ? AND usuario_id = ?',
      whereArgs: [compromisso.id, compromisso.usuarioId],
    );
  }

  static Future<int> excluirCompromisso(int id, int usuarioId) async {
    Database db = await banco();

    return db.delete(
      'compromissos',
      where: 'id = ? AND usuario_id = ?',
      whereArgs: [id, usuarioId],
    );
  }
}
