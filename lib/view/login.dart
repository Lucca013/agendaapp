import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/usuario.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final form = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  Future<void> entrar() async {
    if (!form.currentState!.validate()) return;

    try {
      Usuario? usuario = await BancoDados.autenticar(
        email.text,
        senha.text,
      );

      if (!mounted) return;

      if (usuario == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha incorretos.'),
          ),
        );
      } else {
        Usuario.logado = usuario;

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao entrar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: form,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.login,
                  color: Colors.red,
                  size: 70,
                ),

                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty
                          ? 'Informe o e-mail'
                          : null,
                ),

                TextFormField(
                  controller: senha,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty
                          ? 'Informe a senha'
                          : null,
                ),

                const SizedBox(height: 20),

                FilledButton(
                  onPressed: entrar,
                  child: const Text('Entrar'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/cadastro',
                    );
                  },
                  child: const Text('Ainda não tenho conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
