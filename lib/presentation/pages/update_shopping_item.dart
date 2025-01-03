import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/shopping_item.dart';
import '../../services/shopping_service.dart';
import '../../utils/routes.dart';

class UpdateShoppingItemScreen extends StatefulWidget {
  final String itemName;

  const UpdateShoppingItemScreen({
    super.key,
    required this.itemName,
  });

  @override
  State<UpdateShoppingItemScreen> createState() => _UpdateShoppingItemScreenState();
}

class _UpdateShoppingItemScreenState extends State<UpdateShoppingItemScreen> {
  final ApiService apiService = ApiService();
  ShoppingItem _shoppingItem = ShoppingItem(name: '', amount: 0);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    print('Load Item...');
    try {
      _shoppingItem = await apiService.getItemByName(widget.itemName);
      setState(() {
        _nameController.text = _shoppingItem.name;
        _amountController.text = _shoppingItem.amount.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  void _updateItem() async {
    print('Update Item...');
    final updatedItem = ShoppingItem(name: _nameController.text, amount: int.parse(_amountController.text));
    try {
      await apiService.updateItem(widget.itemName, updatedItem);
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
      appBar: AppBar(title: const Text('Edit Shopping Item')),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
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
                  onPressed: () => _updateItem(),
                  child: const Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
