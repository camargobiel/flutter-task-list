import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

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
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Título da tarefa"),
                icon: Icon(Icons.title),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Descrição"),
                icon: Icon(Icons.description),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Data de conclusão"),
                icon: Icon(Icons.date_range),
              ),
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
                onPressed: () {},
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
