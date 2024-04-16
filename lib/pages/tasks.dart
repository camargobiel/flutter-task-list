import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  void _logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tasks = [
      {
        "title": "Tarefa 1",
        "created_at": DateTime.now().toString(),
      },
      {
        "title": "Tarefa 2",
        "created_at": DateTime.now().toString(),
      },
    ];
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!),
        actions: [
          IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/new-task");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: tasks.length * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Atividades (${tasks.length})",
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: tasks.length * 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...tasks.map((item) => Dismissible(
                          key: Key(item["title"]),
                          onDismissed: (direction) {},
                          background: Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: Text(
                              item["title"],
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              item["created_at"],
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.deepPurple.shade200,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
