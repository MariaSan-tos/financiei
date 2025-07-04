import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

import 'package:financiei/view/main_screen.dart';
import 'package:financiei/view/login_screen.dart';

void main() async {
  // Garante que o Flutter e o Firebase sejam inicializados antes de rodar o app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financiei',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          secondary: Colors.amber,
        ),
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // A "home" agora é o nosso widget de verificação de autenticação
      home: const AuthCheck(),
    );
  }
}

// Este widget é o coração da nossa lógica de login
class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    // O StreamBuilder escuta em tempo real as mudanças no status de login
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Enquanto está conectando, mostra uma tela de carregamento
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 2. Se o snapshot tem dados (usuário não é nulo), o usuário está logado!
        if (snapshot.hasData) {
          // Mostra a tela principal do aplicativo
          return const MainScreen();
        }

        // 3. Se não tem dados, o usuário não está logado
        // Mostra a tela de login
        return const LoginScreen();
      },
    );
  }
}