import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/compromisso.dart';

class TelaEditar extends StatefulWidget {
  final Compromisso compromisso;

  const TelaEditar({super.key, required this.compromisso});

  @override
  State<TelaEditar> createState() => _TelaEditarState();
}

class _TelaEditarState extends State<TelaEditar> {
  final form = GlobalKey<FormState>();

  late final titulo = TextEditingController(
    text: widget.compromisso.titulo,
  );

  late final descricao = TextEditingController(
    text: widget.compromisso.descricao,
  );

  late final data = TextEditingController(
    text: widget.compromisso.data,
  );

  Future<void> salvar() async {
    if (!form.currentState!.validate()) return;

    Compromisso compromisso = Compromisso(
      id: widget.compromisso.id,
      usuarioId: widget.compromisso.usuarioId,
      titulo: titulo.text,
      descricao: descricao.text,
      data: data.text,
    );

    try {
      await BancoDados.atualizarCompromisso(compromisso);

      if (!mounted) return;
      Navigator.pop(context, true);

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar compromisso'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: form,

          child: Column(
            children: [
              TextFormField(
                controller: titulo,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o título' : null,
              ),

              TextFormField(
                controller: descricao,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe a descrição' : null,
              ),

              TextFormField(
                controller: data,
                decoration: const InputDecoration(
                  labelText: 'Data (DD/MM/AAAA)',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe a data' : null,
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar alterações'),
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
