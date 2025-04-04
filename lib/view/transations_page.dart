import 'package:bank/widget/expence_widget.dart';
import 'package:bank/widget/footer.dart';
import 'package:bank/widget/income_widghet.dart';

import 'package:flutter/material.dart';

class TransationsPage extends StatelessWidget {
  const TransationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          ExpenceWidget(),
          IncomeWidghet(),
          Expanded(child: Container()), 
          FooterWidget(),
        ],
      ),
    );
  }
}
