import 'package:flutter/material.dart';
import '../banco de dados/usuario.dart';
import '../utilitarios/formulario.dart';

class telaCadastro extends StatefulWidget {
  const telaCadastro({super.key});

  @override
  State<telaCadastro> createState() => _telaCadastroState();
}

class _telaCadastroState extends State<telaCadastro> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _aceitaReceberEmails = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add, size: 80, color: Colors.red),

                Formulario.campoTexto(
                  controller: _nomeController,
                  label: 'Nome',
                  icone: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu nome';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                Formulario.campoTexto(
                  controller: _emailController,
                  label: 'E-mail',
                  icone: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu e-mail';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                Formulario.campoTexto(
                  controller: _senhaController,
                  label: 'Senha',
                  icone: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),

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

                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Usuario novoUsuario = Usuario(
                          nome: _nomeController.text,
                          email: _emailController.text,
                          senha: _senhaController.text,
                          aceitaReceberEmails: _aceitaReceberEmails,
                        );

                        Usuario.cadastrar(novoUsuario);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuário cadastrado com sucesso!'),
                          ),
                        );

                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Já tenho uma conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
