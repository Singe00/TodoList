import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class Todo{
  bool isDone = false;
  String title;

  Todo(this.title);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}):super(key:key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  final _item = <Todo>[];

  var _todoController = TextEditingController();

  void _addTodo(Todo todo)
  {
    setState(() {
      _item.add(todo);
      _todoController.text='';
    });
  }

  void _deleteTodo(Todo todo)
  {
    setState(() {
      _item.remove(todo);
    });
  }

  void _toggleTodo(Todo todo)
  {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  Widget _buildItemWidget(Todo todo)
  {
    return ListTile(
      onTap: ()=> _toggleTodo(todo),
      title: Text(
        todo.title,
        style: todo.isDone? const TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
        ) : null,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(todo),
      ),
    );
  }

  @override
  void dispose()
  {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                  ),
                ),
                ElevatedButton(
                    onPressed: ()=>_addTodo(Todo(_todoController.text)),
                    child: Text('추가')
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: _item.map((todo) => _buildItemWidget(todo)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
