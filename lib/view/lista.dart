
import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/usuario.dart';
import '../model/compromisso.dart';
import 'editar.dart';

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  Future<List<Compromisso>> registros =
      BancoDados.listarCompromissos(Usuario.logado!.id!);

  void atualizar() {
    setState(() {
      registros = BancoDados.listarCompromissos(Usuario.logado!.id!);
    });
  }

  Future<void> editar(Compromisso compromisso) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaEditar(compromisso: compromisso),
      ),
    );

    if (!mounted) return;
    atualizar();
  }

  Future<void> excluir(Compromisso compromisso) async {
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
        compromisso.id!,
        Usuario.logado!.id!,
      );

      if (!mounted) return;
      atualizar();

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compromissos')),

      body: FutureBuilder<List<Compromisso>>(
        future: registros,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            return const Center(child: CircularProgressIndicator());
          }

          List<Compromisso> lista = snapshot.data!;

          if (lista.isEmpty) {
            return const Center(
              child: Text('Nenhum compromisso cadastrado.'),
            );
          }

          return ListView.builder(
            itemCount: lista.length,

            itemBuilder: (context, index) {
              Compromisso compromisso = lista[index];

              return ListTile(
                title: Text(
                  '${compromisso.id} - ${compromisso.titulo}',
                ),
                subtitle: Text(
                  '${compromisso.descricao}\nData: ${compromisso.data}',
                ),

                onTap: () => editar(compromisso),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editar(compromisso),
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => excluir(compromisso),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/adicionar');

          if (!mounted) return;
          atualizar();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
