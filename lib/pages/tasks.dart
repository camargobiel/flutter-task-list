import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Map<String, dynamic>> tasks = [];
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("tasks");

  void _logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  void _remove(DataSnapshot snapshot) async {
    if (snapshot.key != null) {
      await _databaseRef.child(snapshot.key as String).remove();
    }
  }

  void _check(DataSnapshot snapshot, bool? value) async {
    if (snapshot.key != null) {
      await _databaseRef.child(snapshot.key as String).update({
        "done": value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName!),
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
          child: FirebaseAnimatedList(
            query: _databaseRef,
            defaultChild: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
            itemBuilder: (context, snapshot, animation, index) {
              Map array = snapshot.value as Map;

              return Column(
                children: [
                  Dismissible(
                    key: Key(array["title"]),
                    onDismissed: (direction) {
                      _remove(snapshot);
                    },
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
                      value: array["done"] ?? false,
                      onChanged: (value) {
                        _check(snapshot, value);
                      },
                      title: Row(
                        children: [
                          Text(
                            array["title"],
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 200,
                          ),
                          Text(
                            array["final_date"] != null
                                ? "${array["final_date"]}"
                                : "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        array["description"],
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
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
