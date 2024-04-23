import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  NewTaskPage({super.key});

  _createTask(BuildContext context) async {
    await FirebaseDatabase.instance.ref().child("tasks").push().set({
      "title": titleController.value.text,
      "description": descriptionController.value.text,
      "final_date": dateController.value.text,
    }).whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 380,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Nova tarefa",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Título da tarefa"),
                icon: Icon(Icons.title),
              ),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Descrição"),
                icon: Icon(Icons.description),
              ),
              controller: descriptionController,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Data de conclusão"),
                icon: Icon(Icons.date_range),
              ),
              controller: dateController,
            ),
            /* InputDatePickerFormField(
              firstDate: DateTime.now(),
              lastDate: DateTime.now(),
              fieldLabelText: "Data de conclusão",
              keyboardType: TextInputType.datetime,
            ), */
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(0, 45),
                  ),
                ),
                onPressed: () async {
                  await _createTask(context);
                },
                child: Container(
                  width: 122,
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      Text("Criar atividade"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
