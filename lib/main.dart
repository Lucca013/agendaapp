
import 'package:flutter/material.dart';
import 'view/home.dart';
import 'view/login.dart';
import 'view/cadastro.dart';
import 'view/adicionarAgenda.dart';
import 'view/lista.dart';
import 'view/busca.dart';
import 'view/alterarCadastro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgendaApp',
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

      initialRoute: '/login',

      routes: {
        '/login': (context) => const TelaLogin(),
        '/cadastro': (context) => const TelaCadastro(),
        '/home': (context) => const TelaHome(),
        '/adicionar': (context) => const TelaAdicionar(),
        '/lista': (context) => const TelaLista(),
        '/busca': (context) => const TelaBusca(),
        '/alterarCadastro': (context) => const TelaAlterarCadastro(),
      },
    );
  }
}
