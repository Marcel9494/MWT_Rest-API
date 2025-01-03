import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:middleware_technology/utils/routes.dart';

import '../../models/shopping_item.dart';
import '../../services/shopping_service.dart';

class CreateShoppingItemScreen extends StatefulWidget {
  const CreateShoppingItemScreen({super.key});

  @override
  State<CreateShoppingItemScreen> createState() => _CreateShoppingItemScreenState();
}

class _CreateShoppingItemScreenState extends State<CreateShoppingItemScreen> {
  final ApiService apiService = ApiService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void _addItem() async {
    print('Create Item...');
    final newItem = ShoppingItem(name: _nameController.text, amount: int.parse(_amountController.text));
    try {
      await apiService.addItem(newItem);
      Navigator.pushNamedAndRemoveUntil(context, shoppingItemListRoute, (route) => false);
    } catch (e) {
      print(e);
    }
  }

  String? _checkInput(TextEditingController inputController) {
    if (inputController.text.isEmpty) {
      return 'Bitte geben Sie einen Text ein.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Shopping Item')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 500.0,
              child: TextFormField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                validator: (input) => _checkInput(_nameController),
                decoration: InputDecoration(
                  hintText: 'Name...',
                  counterText: '',
                  prefixIcon: const Icon(Icons.title_rounded),
                  suffixIcon: IconButton(
                    onPressed: () => {
                      _nameController.text = '',
                      FocusScope.of(context).requestFocus(focusNode), // Setzt den Fokus und öffnet die Tastatur
                    },
                    icon: const Icon(Icons.clear_rounded),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 500.0,
              child: TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (input) => _checkInput(_amountController),
                decoration: InputDecoration(
                  hintText: 'Amount...',
                  counterText: '',
                  prefixIcon: const Icon(Icons.money_rounded),
                  suffixIcon: IconButton(
                    onPressed: () => {
                      _amountController.text = '',
                      FocusScope.of(context).requestFocus(focusNode), // Setzt den Fokus und öffnet die Tastatur
                    },
                    icon: const Icon(Icons.clear_rounded),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: 500.0,
                child: ElevatedButton(
                  onPressed: () => _addItem(),
                  child: const Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
