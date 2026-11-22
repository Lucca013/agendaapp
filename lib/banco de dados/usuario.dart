class Usuario {
  String nome;
  String email;
  String senha;
  bool aceitaReceberEmails;

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
    required this.aceitaReceberEmails,
  });

  static List<Usuario> listaUsuarios = [];

  static Usuario? usuarioLogado;

  static void cadastrar(Usuario usuario) {
    listaUsuarios.add(usuario);
  }

  static void logout() {
    usuarioLogado = null;
  }
}