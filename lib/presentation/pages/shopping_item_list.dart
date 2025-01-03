import 'package:flutter/material.dart';
import 'package:middleware_technology/utils/routes.dart';
import 'package:middleware_technology/utils/update_shopping_item_arguments.dart';

import '../../models/shopping_item.dart';
import '../../services/shopping_service.dart';

class ShoppingItemListScreen extends StatefulWidget {
  const ShoppingItemListScreen({super.key});

  @override
  _ShoppingItemListScreenState createState() => _ShoppingItemListScreenState();
}

class _ShoppingItemListScreenState extends State<ShoppingItemListScreen> {
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
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              updateShoppingItemRoute,
              arguments: UpdateShoppingItemArguments(item.name),
            ),
            child: Card(
              child: ListTile(
                title: Text('Name: ${item.name}'),
                subtitle: Text('Amount: ${item.amount}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_rounded, color: Colors.red),
                  onPressed: () => _deleteItem(item.name),
                ),
              ),
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
