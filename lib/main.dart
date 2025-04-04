import 'package:bank/providers/bank_name_provider.dart';
import 'package:bank/providers/card_provider.dart';
import 'package:bank/providers/expences_category_provider.dart';
import 'package:bank/providers/expenses_provider.dart';
import 'package:bank/providers/income_provider.dart';
import 'package:bank/providers/transactions_provider.dart';
import 'package:bank/providers/user_provider.dart';
import 'package:bank/service/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  
  await Supabase.initialize(
    url: 'https://rfbfjtvedvqipdakiitc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmYmZqdHZlZHZxaXBkYWtpaXRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc1NjgxMTksImV4cCI6MjA1MzE0NDExOX0.wEaL4HXbAGrsSUgyAh7FGeeZHX_k3LvrwgBeB_Ntfu4',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => BankNameProvider()),
        ChangeNotifierProvider(create: (_) => TransactionsProvider()),
        ChangeNotifierProvider(create: (context) => ExpencesCategoryProvider()),
        ChangeNotifierProvider(create: (context) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => IncomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    );
  }
}
