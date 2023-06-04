import 'package:flutter/material.dart';
import 'package:todoapp/widgets/add_dialog.dart';
import 'package:todoapp/widgets/checked_Widget.dart';
import 'package:todoapp/widgets/todo_widget.dart';
import 'package:provider/provider.dart';
import 'provider/todo_provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final tabs = [
    Center(
      child: Consumer<ToDoListProvider>(
        builder: (context, value, child) {
          return const TodoListWidget();
        },
      ),
    ),
    Center(
      child: Consumer<ToDoListProvider>(
        builder: (context, value, child) {
          return const FinishedListWidget();
        },
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text(selectedIndex == 0 ?
 'Todo List' : 'Completed Task'),
      actions: [
        IconButton(onPressed: (){
            selectedIndex == 0 ? context.read<ToDoListProvider>().removeAllToDo() : context.read<ToDoListProvider>().removeAllCompleted();
             const snackBar =
              SnackBar(content: Text('List cleared'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }, icon: const Icon(Icons.delete_sweep_rounded))
      ],
        centerTitle: true,
      ),  


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),

      body: tabs[selectedIndex],
    
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) =>
            const AddDialogWidget(),
            barrierDismissible: false,
          );
        
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
