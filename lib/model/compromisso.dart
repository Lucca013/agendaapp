class Compromisso {
  final int? id;
  final int usuarioId;
  final String titulo;
  final String descricao;
  final String data;

  const Compromisso({
    this.id,
    required this.usuarioId,
    required this.titulo,
    required this.descricao,
    required this.data,
  });

  Map<String, Object?> toMap() => {
        'usuario_id': usuarioId,
        'titulo': titulo,
        'descricao': descricao,
        'data': data,
      };

  factory Compromisso.fromMap(Map<String, Object?> map) => Compromisso(
        id: map['id'] as int,
        usuarioId: map['usuario_id'] as int,
        titulo: map['titulo'] as String,
        descricao: map['descricao'] as String,
        data: map['data'] as String,
      );
}
