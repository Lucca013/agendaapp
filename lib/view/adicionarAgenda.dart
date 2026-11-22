import 'package:flutter/material.dart';
import '../banco de dados/compromisso.dart';
import '../utilitarios/formulario.dart';

class telaAdicionarAgenda extends StatefulWidget {
  const telaAdicionarAgenda({super.key});

  @override
  State<telaAdicionarAgenda> createState() => _telaAdicionarAgendaState();
}

class _telaAdicionarAgendaState extends State<telaAdicionarAgenda> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar compromisso')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_task, size: 80, color: Colors.red),

                Formulario.campoTexto(
                  controller: _tituloController,
                  label: 'Título',
                  icone: Icons.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o título do compromisso';
                    }

                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                Formulario.campoTexto(
                  controller: _descricaoController,
                  label: 'Descrição',
                  icone: Icons.description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a descrição do compromisso';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),
                Formulario.campoTexto(
                  controller: _dataController,
                  label: 'Data',
                  icone: Icons.calendar_today,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a data do compromisso';
                    }

                    return null;
                  },
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Compromisso novoCompromisso = Compromisso(
                          titulo: _tituloController.text,
                          descricao: _descricaoController.text,
                          data: _dataController.text,
                        );

                        Compromisso.adicionarCompromisso(novoCompromisso);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Compromisso adicionado com sucesso!',
                            ),
                          ),
                        );

                        Navigator.pushReplacementNamed(
                          context,
                          '/visualizar-agenda',
                        );
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Salvar compromisso',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Voltar para Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
