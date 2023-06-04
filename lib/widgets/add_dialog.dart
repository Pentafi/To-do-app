import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/todo_models.dart';
import 'package:todoapp/provider/todo_provider.dart';


class AddDialogWidget extends StatefulWidget {
  const AddDialogWidget({super.key});

  @override
  State<AddDialogWidget> createState() => _AddDialogWidgetState();
}

class _AddDialogWidgetState extends State<AddDialogWidget> {
  late final TextEditingController _controller;
  late final TextEditingController _descController;

  @override
  void initState() {
    _controller = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Todo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Title',
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 20,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 16),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              height: 50,
              minWidth: double.infinity,
              color: Colors.blue,
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final ToDo newItem = ToDo(
                      toDo: _controller.text,
                      description: _descController.text);
                  context.read<ToDoListProvider>().add(newItem);
                  const snackBar = SnackBar(content: Text('New task has been added'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
          const SizedBox(height: 8),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: Colors.black87,
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
