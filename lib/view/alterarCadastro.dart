
import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/usuario.dart';

class TelaAlterarCadastro extends StatefulWidget {
  const TelaAlterarCadastro({super.key});

  @override
  State<TelaAlterarCadastro> createState() => _TelaAlterarCadastroState();
}

class _TelaAlterarCadastroState extends State<TelaAlterarCadastro> {
  final form = GlobalKey<FormState>();

  final email = TextEditingController(
    text: Usuario.logado?.email ?? '',
  );

  bool aceita = Usuario.logado?.aceitaEmails ?? false;

  Future<void> salvar() async {
    if (Usuario.logado == null || !form.currentState!.validate()) return;

    Usuario atual = Usuario.logado!;

    Usuario novo = Usuario(
      id: atual.id,
      nome: atual.nome,
      email: email.text.toLowerCase(),
      aceitaEmails: aceita,
    );

    try {
      await BancoDados.atualizarUsuario(novo);
      Usuario.logado = novo;

      if (!mounted) return;
      Navigator.pop(context, true);

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao alterar cadastro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alterar cadastro')),

      body: Usuario.logado == null
          ? const Center(child: Text('Nenhum usuário logado.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Form(
                key: form,

                child: Column(
                  children: [
                    const Icon(
                      Icons.manage_accounts,
                      color: Colors.red,
                      size: 70,
                    ),

                    Text('Usuário: ${Usuario.logado!.nome}'),

                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'Novo e-mail',
                      ),
                      validator: (v) =>
                          v == null || !v.contains('@')
                              ? 'Informe um e-mail válido'
                              : null,
                    ),

                    CheckboxListTile(
                      value: aceita,
                      title: const Text(
                        'Receber e-mails sobre compromissos',
                      ),
                      onChanged: (v) {
                        setState(() {
                          aceita = v ?? false;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    FilledButton(
                      onPressed: salvar,
                      child: const Text('Salvar alterações'),
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
