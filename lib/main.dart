import 'package:flutter/material.dart';
import 'view/home.dart';
import 'view/login.dart';
import 'view/cadastro.dart';
import 'view/visualizarAgenda.dart';
import 'view/adicionarAgenda.dart';
import 'view/alterarCadastro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      initialRoute: '/cadastro',

      routes: {
        '/home': (context) => const telaHome(),
        '/login': (context) => const telaLogin(),
        '/cadastro': (context) => const telaCadastro(),
        '/visualizarAgenda': (context) => const telaAgenda(),
        '/adicionarAgenda': (context) => const telaAdicionarAgenda(),
        '/alterarCadastro': (context) => const telaAlterarCadastro(),
      },
    );
  }
}