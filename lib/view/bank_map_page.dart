import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BankMapPage extends StatefulWidget {
  @override
  _BankMapPageState createState() => _BankMapPageState();
}

class _BankMapPageState extends State<BankMapPage> {
  final List<String> banks = [
   'Капитал банка АД Скопје',
    'Комерцијална банка АД Скопје',
    'НЛБ банка АД Скопје',
    'ПроKредит банка АД Скопје',
    'Развојна банка на Северна Македонија АД Скопје',
    'Силк Роуд Банка АД Скопје',
    'Стопанска банка АД Битола',
    'Стопанска банка АД Скопје',
    'ТТК банка АД Скопје',
    'Универзална инвестициона банка АД Скопје',
    'Халк банка АД Скопје',
    'Централна кооперативна банка АД Скопје',
    'Шпаркасе банка АД Скопје',
  ];

  String? selectedBank;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(getUrl()));
  }

  String getUrl() {
    return selectedBank == null
        ? "https://api.krstevski.me/fetch/bank.php"
        : "https://api.krstevski.me/fetch/bank.php?bank=${Uri.encodeComponent(selectedBank!)}";
  }

  void _updateUrl() {
    _controller.loadRequest(Uri.parse(getUrl()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bank Locations")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select a bank"),
              value: selectedBank,
              items: banks.map((bank) {
                return DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value;
                });
                _updateUrl();
              },
            ),
          ),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}