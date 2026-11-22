class Usuario {
  final int? id;
  String nome;
  String email;
  bool aceitaEmails;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.aceitaEmails,
  });

  static Usuario? logado;

  Map<String, Object?> toMap() => {
        'nome': nome.trim(),
        'email': email.trim().toLowerCase(),
        'aceita_emails': aceitaEmails ? 1 : 0,
      };

  factory Usuario.fromMap(Map<String, Object?> map) => Usuario(
        id: map['id'] as int?,
        nome: map['nome'] as String,
        email: map['email'] as String,
        aceitaEmails: (map['aceita_emails'] as int) == 1,
      );

  static void sair() => logado = null;
}
