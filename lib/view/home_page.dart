
import 'package:bank/providers/bank_name_provider.dart';
import 'package:bank/providers/card_provider.dart';
import 'package:bank/providers/expenses_provider.dart';
import 'package:bank/providers/income_provider.dart';
import 'package:bank/providers/user_provider.dart';
import 'package:bank/view/add_card_page.dart';
import 'package:bank/view/edit_card_page.dart';
import 'package:bank/widget/footer.dart';
import 'package:bank/widget/bank_card_widget.dart';
import 'package:bank/widget/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bank/providers/expences_category_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);
    final expensesProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    final categoryProvider = Provider.of<ExpencesCategoryProvider>(context, listen: false);

    cardProvider.loadCards();
    expensesProvider.loadExpenses();
    incomeProvider.loadIncomes();
    categoryProvider.loadExpensesCategories();
  });
}


  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final bankNameProvider = Provider.of<BankNameProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            

            SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Cards',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: cardProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cardProvider.cards.length,
                      itemBuilder: (context, index) {
                        final card = cardProvider.cards[index];
                        return FutureBuilder<String?>(
                          future: bankNameProvider.getBankNameById(card.bankId),
                          builder: (context, snapshot) {
                            final bankName = snapshot.data ?? 'Loading...';
                            return ListTile(
                              title: Text('Card: ${card.transactionNumber}'),
                              subtitle: Text('Bank: $bankName'),
                              onTap: () {
                                cardProvider.selectCard(card);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddCardPage()),
                  );
                  cardProvider.loadCards();
                },
                child: const Text('Add Card'),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () => Provider.of<UserProvider>(context, listen: false).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          if (cardProvider.selectedCard != null)
            Expanded(
              child: FutureBuilder<String?>(
                future: bankNameProvider.getBankNameById(cardProvider.selectedCard!.bankId),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      BankCardWidget(
                        transactionNumber: cardProvider.selectedCard!.transactionNumber,
                        expirationDate: cardProvider.selectedCard!.expirationDate,
                        balance: cardProvider.selectedCard!.balance.toDouble(),
                        bankName: snapshot.data ?? 'Loading...',
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCardPage(card: cardProvider.selectedCard!),
                            ),
                          ).then((_) => cardProvider.loadCards());
                        },
                        onDelete: () async {
                          await cardProvider.deleteCard(cardProvider.selectedCard!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Card deleted successfully')),
                          );
                          cardProvider.clearSelectedCard();
                        },
                      ),
                      Expanded(
                        child: Consumer3<ExpensesProvider, IncomeProvider, ExpencesCategoryProvider>(
                          builder: (context, expenses, incomes, categories, _) {
                            final transactions = [
                              ...expenses.expenses.where((e) => e.transactionId == cardProvider.selectedCard!.id),
                              ...incomes.incomes.where((i) => i.transactionId == cardProvider.selectedCard!.id),
                            ];

                            return ListView.builder(
                              padding: const EdgeInsets.only(top: 16, bottom: 80),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: transactions.length,
                              itemBuilder: (context, index) => TransactionItem(
                                transaction: transactions[index],
                                categoryProvider: categories,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          else
            const Center(child: Text('Select a card from the drawer')),
          const FooterWidget(),
        ],
      ),
    );
  }
}
