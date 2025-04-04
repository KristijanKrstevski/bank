import 'package:bank/model/expense.dart';
import 'package:bank/providers/card_provider.dart';
import 'package:bank/providers/expenses_provider.dart';
import 'package:bank/widget/popups/category_pop_up.dart';
import 'package:bank/widget/popups/create_category_pop_up.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenceWidget extends StatefulWidget {
  const ExpenceWidget({super.key});

  @override
  State<ExpenceWidget> createState() => _ExpenceWidgetState();
}

class _ExpenceWidgetState extends State<ExpenceWidget> {
  String? selectedCategoryName;
  String? selectedCategoryEmoji;
  int? selectedCategoryId;
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
          color: const Color.fromARGB(255, 188, 0, 8),
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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return CategoryPopUp(
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategoryName = category.category_name;
                              selectedCategoryEmoji = category.emoji;
                              selectedCategoryId = category.id;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    selectedCategoryName != null
                        ? "$selectedCategoryEmoji  $selectedCategoryName"
                        : 'Select Your Category',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateCategoryPopUp(),
                    );
                  },
                  child: DottedBorder(
                    color: Colors.blue,
                    strokeWidth: 2,
                    dashPattern: const [6, 4],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(16),
                    child: const SizedBox(
                      height: 70,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
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
                    
                    if (selectedCategoryId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a category')),
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
                      final provider = Provider.of<ExpensesProvider>(context, listen: false);
                      await provider.addExpence(
                        Expense(
                          transactionId: cardProvider.selectedCard!.id!,
                          amount: amount,
                          categoryId: selectedCategoryId!,
                        ),
                      );
                      await cardProvider.loadCards();
      await provider.loadExpenses();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Expense saved successfully')),
                      );
                      
                      _amountController.clear();
                      setState(() {
                        selectedCategoryName = null;
                        selectedCategoryEmoji = null;
                        selectedCategoryId = null;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error saving expense: $e')),
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