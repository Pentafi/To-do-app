import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/todo_models.dart';
import 'package:todoapp/provider/todo_provider.dart';

class EditDialogWidget extends StatefulWidget {
  final ToDo toDo;

  const EditDialogWidget({Key? key, required this.toDo}) : super(key: key);

  @override
  State<EditDialogWidget> createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  late final TextEditingController _controller;
  late final TextEditingController _descController;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.toDo.item);
    _descController = TextEditingController(text: widget.toDo.desc);
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Edit Todo'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ToDoListProvider>().remove(widget.toDo.getID);
                const snackBar =
                    SnackBar(content: Text('Task has been removed'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  // hintText: 'Edit Title here',
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
                  hintText: 'Edit Description here',
                  // labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      final todo = widget.toDo;
                      final editTitle = _controller.text;
                      final editDesc = _descController.text;

                      context
                          .read<ToDoListProvider>()
                          .edit(todo.getID, editTitle, editDesc);
                      const snackBar = SnackBar(
                          content: Text('Task has been editted'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Enter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
