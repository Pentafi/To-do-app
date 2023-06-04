import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/todo_models.dart';
import 'package:todoapp/provider/todo_provider.dart';


class FinishedWidget extends StatelessWidget {
  final ToDo finished;

  const FinishedWidget({
    required this.finished,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                onPressed: (context) {
                  const snackBar =
                  SnackBar(content: Text('Task has been removed'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  context
                      .read<ToDoListProvider>()
                      .removeFromCompletedList(finished.getID);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete'),
          ],
        ),
        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: finished.isDone,
                onChanged: ((_) async {
                  context
                      .read<ToDoListProvider>()
                      .setTaskUnfinish(finished.getID);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    context
                        .read<ToDoListProvider>()
                        .transferUnfinished(finished.getID);
                    const snackBar = SnackBar(content: Text('Task marked as unfinished'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    finished.item,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (finished.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        finished.description,
                        style: const TextStyle(fontSize: 20, height: 1.5),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
