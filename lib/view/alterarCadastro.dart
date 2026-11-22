import 'package:flutter/material.dart';
import '../banco de dados/usuario.dart';
import '../utilitarios/formulario.dart';

class telaAlterarCadastro extends StatefulWidget {
  const telaAlterarCadastro({super.key});

  @override
  State<telaAlterarCadastro> createState() => _telaAlterarCadastroState();
}

class _telaAlterarCadastroState extends State<telaAlterarCadastro> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  bool _aceitaReceberEmails = false;

  @override
  void initState() {
    super.initState();

    if (Usuario.usuarioLogado != null) {
      _emailController.text = Usuario.usuarioLogado!.email;
      _aceitaReceberEmails = Usuario.usuarioLogado!.aceitaReceberEmails;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Usuario.usuarioLogado == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Alterar cadastro')),
        body: const Center(child: Text('Nenhum usuário está logado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Alterar cadastro')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.manage_accounts, size: 80, color: Colors.red),

                Text(
                  'Usuário: ${Usuario.usuarioLogado!.nome}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Formulario.campoTexto(
                  controller: _emailController,
                  label: 'Novo e-mail',
                  icone: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu e-mail';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),
                Formulario.campoCheckbox(
                  valor: _aceitaReceberEmails,
                  texto: 'Aceito receber e-mails sobre meus compromissos',
                  onChanged: (value) {
                    setState(() {
                      _aceitaReceberEmails = value ?? false;
                    });
                  },
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (Usuario.usuarioLogado != null) {
                          Usuario.usuarioLogado!.email = _emailController.text;
                          Usuario.usuarioLogado!.aceitaReceberEmails = _aceitaReceberEmails;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cadastro alterado com sucesso!'),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Nenhum usuário está logado.'),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Salvar alterações',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

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
