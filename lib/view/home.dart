
import 'package:flutter/material.dart';
import '../model/usuario.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgendaApp')),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_month,
                color: Colors.red,
                size: 90,
              ),

              Text(
                'Bem-vindo, ${Usuario.logado?.nome ?? 'usuário'}!',
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/adicionar');
                },
                icon: const Icon(Icons.add),
                label: const Text('Cadastrar compromisso'),
              ),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/lista');
                },
                icon: const Icon(Icons.list),
                label: const Text('Listar compromissos'),
              ),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/busca');
                },
                icon: const Icon(Icons.search),
                label: const Text('Consultar por ID'),
              ),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/alterarCadastro');
                },
                icon: const Icon(Icons.manage_accounts),
                label: const Text('Alterar cadastro'),
              ),

              const SizedBox(height: 20),

              OutlinedButton.icon(
                onPressed: () {
                  Usuario.sair();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
