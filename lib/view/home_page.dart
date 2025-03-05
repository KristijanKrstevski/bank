import 'package:bank/providers/bank_name_provider.dart';
import 'package:bank/providers/card_provider.dart';
import 'package:bank/providers/user_provider.dart';
import 'package:bank/view/add_card_page.dart';
import 'package:bank/view/edit_card_page.dart';
import 'package:bank/widget/footer.dart';
import 'package:bank/widget/bank_card_widget.dart';
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
    Provider.of<CardProvider>(context, listen: false).loadCards();
  }

  var _selectedCard;

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final bankNameProvider = Provider.of<BankNameProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text('Profile'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Cards',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                setState(() {
                                  _selectedCard = card;
                                });
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
      body: Stack(
        children: [
          Column(
            children: [
              if (_selectedCard != null)
                FutureBuilder<String?>(
                  future: bankNameProvider.getBankNameById(_selectedCard.bankId),
                  builder: (context, snapshot) {
                    final bankName = snapshot.data ?? 'Loading...';
                    return BankCardWidget(
                      transactionNumber: _selectedCard.transactionNumber,
                      expirationDate: _selectedCard.expirationDate,
                      balance: _selectedCard.balance,
                      bankName: bankName,
                      
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCardPage(card: _selectedCard),
                          ),
                        ).then((_) => cardProvider.loadCards());
                      },
                      onDelete: () async {
                        await cardProvider.deleteCard(_selectedCard);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Card deleted successfully')),
                        );
                        setState(() {
                          _selectedCard = null;
                        });
                      },
                    );
                  },
                )
              else
                const Center(child: Text('Select a card from the drawer')),
            ],
          ),
          FooterWidget(),
        ],
      ),
    );
  }
}
