import 'dart:convert';
import 'package:flutter_api_project/todo_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  // Fetch all todos
  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  // Create a new todo
  static Future<Todo> createTodo(String title) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode({
        'title': title,
        'completed': false,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  // Update a todo
  static Future<Todo> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${todo.id}'),
      body: json.encode(todo.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  // Delete a todo
  static Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}