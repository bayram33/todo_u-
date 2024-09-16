import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_storage/models/task_model.dart';
import 'package:local_storage/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Task> _tasks = []; // List to store tasks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do ",
          textAlign: TextAlign.right,
          style: GoogleFonts.alata(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      _tasks.removeAt(index);
                    });
                  },
                  background: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Görevi sil",
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: TaskItems(task: task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Add Task",
              style: GoogleFonts.abel(),
            ),
          ),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              labelText: "Add New Task",
            ),
          ),
          actions: [
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  Navigator.of(context).pop();

                  // Zaman seçici açılıyor
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  // Eğer kullanıcı bir zaman seçtiyse ve task adı doluysa
                  if (pickedTime != null && taskController.text.isNotEmpty) {
                    setState(() {
                      // TimeOfDay'i DateTime'a çevir
                      final now = DateTime.now();
                      final createdAt = DateTime(now.year, now.month, now.day,
                          pickedTime.hour, pickedTime.minute);

                      // Task model'i oluştur ve listeye ekle
                      final newTask = Task.create(
                          name: taskController.text, createdAt: createdAt);
                      _tasks.add(newTask);

                      // Seçilen saati güncelle
                    });
                  }
                },
                icon: const Icon(Icons.send_rounded),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Send"),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 25),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  backgroundColor: Colors.deepOrange.shade400,
                  iconColor: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
