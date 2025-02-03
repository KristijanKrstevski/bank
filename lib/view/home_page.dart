import 'package:bank/providers/bank_name_provider.dart';
import 'package:bank/providers/card_provider.dart';
import 'package:bank/providers/user_provider.dart';
import 'package:bank/view/add_card_page.dart';
import 'package:bank/view/edit_card_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load cards when the page is loaded
    Provider.of<CardProvider>(context, listen: false).loadCards();
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final bankNameProvider = Provider.of<BankNameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => Provider.of<UserProvider>(context, listen: false).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cardProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: cardProvider.cards.length,
                    itemBuilder: (context, index) {
                      final card = cardProvider.cards[index];
                      return FutureBuilder<String?>(
                        future: bankNameProvider.getBankNameById(card.bankId),
                        builder: (context, snapshot) {
                          final bankName = snapshot.data ?? 'Loading...';
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text('Card: ${card.transactionNumber}'),
                              subtitle: Text(
                                  'Expires: ${card.expirationDate} | Balance: ${card.balance} | Bank: $bankName'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Navigate to the Edit Card page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditCardPage(card: card),
                                        ),
                                      ).then((_) {
                                        // Refresh the list after editing
                                        cardProvider.loadCards();
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      // Delete the card and reload the list
                                      await cardProvider.deleteCard(card);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Card deleted successfully')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
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
                // Navigate to AddCardPage and refresh the list after adding a new card
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCardPage()),
                );
                cardProvider.loadCards(); // Refresh the list of cards
              },
              child: const Text('Add Card'),
            ),
          ),
        ],
      ),
    );
  }
}
