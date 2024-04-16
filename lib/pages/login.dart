import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String? emailError;

  String? passwordError;

  void _authUser(BuildContext context) async {
    emailError = null;
    passwordError = null;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, "/tasks");
    } catch (e) {
      setState(() {
        String error = e.toString();
        if (error.contains("invalid-email") == true) {
          emailError = "E-mail inválido";
        }
        if (error.contains("missing-password")) {
          passwordError = "Senha inválida";
        }
        if (error.contains("weak-password")) {
          passwordError = "Senha fraca. Digite no mínimo 6 caracteres";
        }
        if (error.contains("invalid-credential")) {
          emailError = "E-mail ou senha inválidos";
          passwordError = "E-mail ou senha inválidos";
        }
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(82, 255, 255, 255),
              Color.fromARGB(105, 191, 107, 255),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 460,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple.shade200),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 247, 247, 247),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Digite seus dados para entrar na plataforma",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("E-mail"),
                        error: emailError != null
                            ? Text(
                                emailError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : null,
                      ),
                      controller: emailController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        label: const Text("Senha"),
                        border: const OutlineInputBorder(),
                        error: passwordError != null
                            ? Text(
                                passwordError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : null,
                      ),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            _authUser(context);
                          },
                          child: const Text("Entrar"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/register");
                          },
                          child: const Text(
                            "Ainda não tem conta? Clique aqui e cadastre-se.",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
