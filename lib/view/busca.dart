
import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/usuario.dart';
import '../model/compromisso.dart';
import 'editar.dart';

class TelaBusca extends StatefulWidget {
  const TelaBusca({super.key});

  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  final id = TextEditingController();
  Compromisso? resultado;
  String mensagem = '';

  Future<void> buscar() async {
    int? numero = int.tryParse(id.text);

    if (numero == null || numero <= 0) {
      setState(() {
        resultado = null;
        mensagem = 'Informe um ID válido.';
      });
      return;
    }

    try {
      Compromisso? compromisso = await BancoDados.buscarCompromisso(
        numero,
        Usuario.logado!.id!,
      );

      if (!mounted) return;

      setState(() {
        resultado = compromisso;
        mensagem = compromisso == null
            ? 'Compromisso não encontrado.'
            : '';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        resultado = null;
        mensagem = 'Erro ao buscar: $e';
      });
    }
  }

  Future<void> editar() async {
    if (resultado == null) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaEditar(compromisso: resultado!),
      ),
    );

    if (!mounted) return;
    await buscar();
  }

  Future<void> excluir() async {
    if (resultado == null) return;

    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir compromisso?'),
        content: const Text('Deseja excluir este compromisso?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmar != true || !mounted) return;

    try {
      await BancoDados.excluirCompromisso(
        resultado!.id!,
        Usuario.logado!.id!,
      );

      if (!mounted) return;

      setState(() {
        resultado = null;
        mensagem = 'Compromisso excluído com sucesso.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        mensagem = 'Erro ao excluir: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar compromisso')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: id,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ID do compromisso',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: buscar,
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
            ),

            if (mensagem.isNotEmpty)
              Text(mensagem),

            if (resultado != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${resultado!.id}'),
                      Text('Título: ${resultado!.titulo}'),
                      Text('Descrição: ${resultado!.descricao}'),
                      Text('Data: ${resultado!.data}'),

                      const SizedBox(height: 12),

                      FilledButton.icon(
                        onPressed: editar,
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar'),
                      ),

                      OutlinedButton.icon(
                        onPressed: excluir,
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
