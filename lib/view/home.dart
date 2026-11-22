import 'package:flutter/material.dart';
import '../banco de dados/usuario.dart';

class telaHome extends StatelessWidget {
  const telaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month, size: 90, color: Colors.red),

              const Text('Bem-vindo à Agenda App',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/adicionarAgenda');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Adicionar na Agenda',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/visualizarAgenda');
                  },
                  icon: const Icon(Icons.visibility),
                  label: const Text(
                    'Ver Agenda',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/alterarCadastro');
                  },
                  icon: const Icon(Icons.manage_accounts),
                  label: const Text(
                    'Alterar cadastro',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Usuario.logout();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
