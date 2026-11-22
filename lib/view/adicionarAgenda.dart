import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/usuario.dart';
import '../model/compromisso.dart';

class TelaAdicionar extends StatefulWidget {
  const TelaAdicionar({super.key});

  @override
  State<TelaAdicionar> createState() => _TelaAdicionarState();
}

class _TelaAdicionarState extends State<TelaAdicionar> {
  final form = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final descricao = TextEditingController();
  final data = TextEditingController();

  Future<void> salvar() async {
    if (form.currentState!.validate()) {
      try {
        Compromisso compromisso = Compromisso(
          usuarioId: Usuario.logado!.id!,
          titulo: titulo.text,
          descricao: descricao.text,
          data: data.text,
        );

        await BancoDados.inserirCompromisso(compromisso);

        if (!mounted) return;
        Navigator.pop(context, true);

      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo compromisso')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: form,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_task, color: Colors.red, size: 70),

                TextFormField(
                  controller: titulo,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe o título' : null,
                ),

                TextFormField(
                  controller: descricao,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  maxLines: 2,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a descrição' : null,
                ),

                TextFormField(
                  controller: data,
                  decoration: const InputDecoration(labelText: 'Data (DD/MM/AAAA)'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a data' : null,
                ),

                const SizedBox(height: 20),

                FilledButton.icon(
                  onPressed: salvar,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar compromisso'),
                ),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
