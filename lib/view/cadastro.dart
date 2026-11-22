import 'package:flutter/material.dart';
import '../utilitarios/bancoDados.dart';
import '../model/usuario.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final form = GlobalKey<FormState>();
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  bool aceitaEmails = false;

  Future<void> cadastrar() async {
    if (!form.currentState!.validate()) return;

    Usuario usuario = Usuario(
      nome: nome.text,
      email: email.text.toLowerCase(),
      aceitaEmails: aceitaEmails,
    );

    try {
      Usuario? salvo = await BancoDados.inserirUsuario(
        usuario,
        senha.text,
      );

      if (!mounted) return;

      if (salvo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail já cadastrado.')),
        );
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de usuário')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: form,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person_add,
                  size: 70,
                  color: Colors.red,
                ),

                TextFormField(
                  controller: nome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe seu nome' : null,
                ),

                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (v) =>
                      v == null || !v.contains('@')
                          ? 'Informe um e-mail válido'
                          : null,
                ),

                TextFormField(
                  controller: senha,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe uma senha' : null,
                ),

                CheckboxListTile(
                  value: aceitaEmails,
                  title: const Text(
                    'Aceito receber e-mails sobre meus compromissos',
                  ),
                  onChanged: (v) {
                    setState(() {
                      aceitaEmails = v ?? false;
                    });
                  },
                ),

                const SizedBox(height: 20),

                FilledButton(
                  onPressed: cadastrar,
                  child: const Text('Cadastrar'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Já tenho conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
