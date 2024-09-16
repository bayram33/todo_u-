import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:local_storage/models/task_model.dart";

class TaskItems extends StatefulWidget {
  final Task task;
  const TaskItems({super.key, required this.task});

  @override
  State<TaskItems> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItems> {
  final TextEditingController _taskNameController = TextEditingController();

  @override
  void initState() {
    _taskNameController.text = widget.task.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius:5,
                offset: Offset(3, 5)
              )
            ] ,
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepOrange.shade100,
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                });
              },
              child: Icon(
                Icons.check_box_outlined,
                color: widget.task.isCompleted ? Colors.green : Colors.grey,
              ),
            ),
            title: widget.task.isCompleted
                ? Text(
                    widget.task.name,
                    style: TextStyle(
                        decoration: widget.task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _taskNameController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          widget.task.name = value;
                        });
                      },
                      maxLines: null,
                    ),
                  ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("h:mm a").format(widget.task.createdAt),
                  style: TextStyle(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                Text(
                  DateFormat("yyyy/MM/dd").format(widget.task.createdAt),
                  style: TextStyle(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
