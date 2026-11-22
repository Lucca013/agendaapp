import 'package:flutter/material.dart';
import '../banco de dados/compromisso.dart';

class telaAgenda extends StatefulWidget {
  const telaAgenda({super.key});

  @override
  State<telaAgenda> createState() => _telaAgendaState();
}

class _telaAgendaState extends State<telaAgenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha agenda'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Compromisso.listaCompromissos.isEmpty? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.event_busy,
                      size: 80,
                      color: Colors.red,
                    ),

                    const Text(
                      'Nenhum compromisso cadastrado.',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton.icon(
                        onPressed: (){
                          Navigator.pushNamed(context, '/adicionar-agenda');
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Adicionar compromisso',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Voltar para Home'),
                    ),
                  ],
                ),
              )
          : ListView.builder(
              itemCount: Compromisso.listaCompromissos.length,

              itemBuilder: (context, index) {
                final compromisso = Compromisso.listaCompromissos[index];

                return ListTile(
                  title: Text(compromisso.titulo),

                  subtitle: Text(
                    '${compromisso.descricao}\nData: ${compromisso.data}',
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),

                    onPressed: () {
                      setState(() {
                        Compromisso.removerCompromisso(index);
                      });
                    },
                  ),
                );
              },
            ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/adicionar-agenda');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}