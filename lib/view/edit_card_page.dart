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

  Widget _buildTextField({required String label, required TextEditingController controller, TextInputType? inputType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: inputType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Card"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
                 
            width: 800,
            child: Column(
              
              children: [
                _buildTextField(label: 'Transaction Number', controller: _transactionNumberController),
                const SizedBox(height: 12),
                _buildTextField(label: 'Expiration Date (YYYY-MM-DD)', controller: _expirationDateController),
                const SizedBox(height: 12),
                _buildTextField(label: 'Balance', controller: _balanceController, inputType: TextInputType.number),
                const SizedBox(height: 12),
                _buildTextField(label: 'Bank ID', controller: _bankIdController, inputType: TextInputType.number),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateCard,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Update Card', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}