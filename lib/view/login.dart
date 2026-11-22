import 'package:flutter/material.dart';
import '../banco de dados/usuario.dart';
import '../utilitarios/formulario.dart';

class telaLogin extends StatefulWidget {
  const telaLogin({super.key});

  @override
  State<telaLogin> createState() => _telaLoginState();
}

class _telaLoginState extends State<telaLogin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.login,
                  size: 80,
                  color: Colors.red,
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

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text;
                        String senha = _senhaController.text;

                      var usuarioEncontrado = Usuario.listaUsuarios.where((usuario) {
                        return usuario.email == email && usuario.senha == senha;
                      }).toList();

                      if (usuarioEncontrado.isNotEmpty) {
                        Usuario.usuarioLogado = usuarioEncontrado.first;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login realizado com sucesso!'),
                          ),
                        );

                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('E-mail ou senha incorretos.'),
                          ),
                        );
                      }
                    }
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                TextButton(
                  onPressed: (){
                      Navigator.pushReplacementNamed(context, '/cadastro');
                  },
                  child: const Text('Ainda não tenho uma conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}