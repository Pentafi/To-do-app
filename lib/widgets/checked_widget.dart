import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/widgets/checked.dart';

class FinishedListWidget extends StatelessWidget {
  const FinishedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoListProvider>(context);
    final finished = provider.completed;

    return finished.isEmpty
        ? const Center(
            child: Text(
              'No finished Task.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: finished.length,
            itemBuilder: (context, index) {
              final completed = finished[index];

              return FinishedWidget(finished: completed);
            },
          );
  }
}
