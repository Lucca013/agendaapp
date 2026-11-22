class Compromisso {
  final String titulo;
  final String descricao;
  final String data;

  Compromisso({
    required this.titulo,
    required this.descricao,
    required this.data,
  });

  static List<Compromisso> listaCompromissos = [];

  static void adicionarCompromisso(Compromisso compromisso) {
    listaCompromissos.add(compromisso);
  }

  static void removerCompromisso(int index) {
    listaCompromissos.removeAt(index);
  }
}