import 'package:flutter/material.dart';
import 'package:middleware_technology/utils/routes.dart';

import '../../models/shopping_item.dart';
import '../../services/shopping_service.dart';

class ShoppingItemsScreen extends StatefulWidget {
  const ShoppingItemsScreen({super.key});

  @override
  _ShoppingItemsScreenState createState() => _ShoppingItemsScreenState();
}

class _ShoppingItemsScreenState extends State<ShoppingItemsScreen> {
  final ApiService apiService = ApiService();
  List<ShoppingItem> shoppingItems = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  void _fetchItems() async {
    try {
      final items = await apiService.getAllItems();
      setState(() {
        shoppingItems = items;
      });
    } catch (e) {
      print(e);
    }
  }

  void _deleteItem(String name) async {
    try {
      await apiService.deleteItem(name);
      _fetchItems();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Item List')),
      body: ListView.builder(
        itemCount: shoppingItems.length,
        itemBuilder: (context, index) {
          final item = shoppingItems[index];
          return ListTile(
            title: Text('Name: ${item.name}'),
            subtitle: Text('Amount: ${item.amount}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
              onPressed: () => _deleteItem(item.name),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, createShoppingItemRoute),
        child: const Icon(Icons.add),
      ),
    );
  }
}
