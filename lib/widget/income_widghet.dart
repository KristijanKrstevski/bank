import 'package:bank/model/income.dart';
import 'package:bank/providers/card_provider.dart';
import 'package:bank/providers/income_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeWidghet extends StatefulWidget {
  const IncomeWidghet({super.key});

  @override
  State<IncomeWidghet> createState() => _IncomeWidghetState();
}

class _IncomeWidghetState extends State<IncomeWidghet> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 118, 242, 64),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Consumer<CardProvider>(
                  builder: (context, cardProvider, _) {
                    if (cardProvider.selectedCard == null) {
                      return const Text('No card selected',
                          style: TextStyle(color: Colors.white));
                    }
                    return Text(
                      'Selected Card: ${cardProvider.selectedCard!.transactionNumber}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Amount',
                    contentPadding: const EdgeInsets.all(30),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    final amount = int.tryParse(_amountController.text);
                    final cardProvider = Provider.of<CardProvider>(context, listen: false);
                    
                    if (amount == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid amount')),
                      );
                      return;
                    }
                    
                    if (cardProvider.selectedCard == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a card from the drawer')),
                      );
                      return;
                    }

                    try {
                      final provider = Provider.of<IncomeProvider>(context, listen: false);
                      await provider.addIncome(
                        Income(
                          transactionId: cardProvider.selectedCard!.id!,
                          amount: amount,
                        ),
                      );
                       await cardProvider.loadCards();
                      await provider.loadIncomes();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Income saved successfully')),
                      );
                      
                      _amountController.clear();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error saving income: $e')),
                      );
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}