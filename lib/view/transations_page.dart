import 'package:bank/widget/expence_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        ]
      )
    );
  }
}