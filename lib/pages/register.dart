import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/errors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  Map<String, String> formErrors = {};

  void _createUser(BuildContext context) async {
    emailError = null;
    passwordError = null;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, "/login");
    } catch (err) {
      _formatErrors(err);
    }
  }

  void _formatErrors(Object err) {
    formErrors = {};
    String error = err.toString();
    String customError = errors[error] ?? "Erro desconhecido";
    setState(() {
      if (customError.toLowerCase().contains("senha")) {
        formErrors["password"] = customError;
      } else if (customError.toLowerCase().contains("e-mail")) {
        formErrors["email"] = customError;
      } else {
        formErrors["email"] = customError;
        formErrors["password"] = customError;
      }
    });
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
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
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
                      "Fazer cadastro",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Digite seus dados para cadastrar na plataforma.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                    /* const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Nome completo"),
                      ),
                    ), */
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
                    /* const TextField(
                      decoration: InputDecoration(
                        label: Text("Confirmar senha"),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ), */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            _createUser(context);
                          },
                          child: const Text("Cadastrar"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text(
                            "Já tem conta na plataforma? Clique para entrar.",
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
