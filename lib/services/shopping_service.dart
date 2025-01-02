import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/shopping_item.dart';

class ApiService {
  final String baseUrl = "https://miniature-space-waddle-jjj74w7pwjpfpxwp-8080.app.github.dev/api/shoppingItems";

  Future<List<ShoppingItem>> getAllItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> items = jsonDecode(response.body);
      return items.map((item) => ShoppingItem.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load shopping items");
    }
  }

  Future<ShoppingItem> getItemByName(String name) async {
    final response = await http.get(Uri.parse("$baseUrl/$name"));
    if (response.statusCode == 200) {
      return ShoppingItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Item not found");
    }
  }

  Future<void> addItem(ShoppingItem item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Failed to add item");
    }
  }

  Future<void> updateItem(String name, ShoppingItem updatedItem) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$name"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedItem.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update item");
    }
  }

  Future<void> deleteItem(String name) async {
    final response = await http.delete(Uri.parse("$baseUrl/$name"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete item");
    }
  }
}
