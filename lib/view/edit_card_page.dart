import 'package:flutter/material.dart';
import 'package:bank/model/card.dart';
import 'package:bank/service/card_service.dart';

class EditCardPage extends StatefulWidget {
  final Cards card;

  const EditCardPage({Key? key, required this.card}) : super(key: key);

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  final _transactionNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _balanceController = TextEditingController();
  final _bankIdController = TextEditingController();

  final CardService _cardService = CardService();

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with the current card data
    _transactionNumberController.text = widget.card.transactionNumber;
    _expirationDateController.text = widget.card.expirationDate;
    _balanceController.text = widget.card.balance.toString();
    _bankIdController.text = widget.card.bankId.toString();
  }

  Future<void> _updateCard() async {
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

    final updatedCard = Cards(
      id: widget.card.id,
      userId: widget.card.userId,
      transactionNumber: transactionNumber,
      expirationDate: expirationDate,
      balance: balance,
      bankId: bankId,
    );

    try {
      await _cardService.updateCard(updatedCard);
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
      appBar: AppBar(title: const Text("Edit Card")),
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
            onPressed: _updateCard,
            child: const Text('Update Card'),
          ),
        ],
      ),
    );
  }
}