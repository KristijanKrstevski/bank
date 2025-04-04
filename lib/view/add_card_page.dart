import 'package:bank/model/card.dart';
import 'package:bank/service/card_service.dart';
import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _transactionNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _balanceController = TextEditingController();
  final _bankIdController = TextEditingController();

  final _cardService = CardService();

  void _addCard() async {
    final transactionNumber = _transactionNumberController.text;
    final expirationDate = _expirationDateController.text;
    final balance = int.tryParse(_balanceController.text);
    final bankId = int.tryParse(_bankIdController.text);

    if (transactionNumber.isEmpty || expirationDate.isEmpty || balance == null || bankId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
      return;
    }

    final card = Cards(
      transactionNumber: transactionNumber,
      expirationDate: expirationDate,
      balance: balance,
      bankId: bankId,
    );

    try {
      await _cardService.addCard(card);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Card")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _transactionNumberController,
            decoration: const InputDecoration(
              labelText: 'Transaction Number',
              hintText: 'Enter transaction number',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _expirationDateController,
            decoration: const InputDecoration(
              labelText: 'Expiration Date',
              hintText: 'YYYY-MM-DD',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _balanceController,
            decoration: const InputDecoration(
              labelText: 'Balance',
              hintText: 'Enter balance',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bankIdController,
            decoration: const InputDecoration(
              labelText: 'Bank ID',
              hintText: 'Enter bank ID',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _addCard,
            child: const Text('Add Card'),
          ),
        ],
      ),
    );
  }
}