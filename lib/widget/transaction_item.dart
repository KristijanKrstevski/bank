
import 'package:bank/model/income.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:bank/providers/expences_category_provider.dart';
class TransactionItem extends StatelessWidget {
  final dynamic transaction;
  final ExpencesCategoryProvider categoryProvider;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.categoryProvider,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction is Income;
    final dateFormat = DateFormat('dd MMM yyyy');
    
    return Container(
      height: 50,
      constraints: const BoxConstraints(minHeight: 50),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
       padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
 
      child: Row(
        children: [
         
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isIncome ? Colors.red : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: isIncome
                ? const Icon(Icons.attach_money_sharp, size: 24)
                : FutureBuilder(
                    future: categoryProvider.getCategoryById(transaction.categoryId),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData ? snapshot.data!.emoji : '📦',
                        style: const TextStyle(fontSize: 24),
                      );
                    },
                  ),
          ),
          
          const SizedBox(width: 15),
          
        
          Expanded(
            child: Text(
              '${transaction.amount} MKD',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            dateFormat.format(
              isIncome ? transaction.incomeDate! : transaction.expenseDate!
            ),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}