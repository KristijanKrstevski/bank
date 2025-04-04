import 'package:flutter/material.dart';
import 'package:bank/model/card.dart';
import 'package:bank/service/card_service.dart';

class CardProvider with ChangeNotifier {
  List<Cards> _cards = [];
  Cards? _selectedCard;
  final CardService _cardService = CardService();
  bool _isLoading = false;

  List<Cards> get cards => _cards;
  bool get isLoading => _isLoading;
  Cards? get selectedCard => _selectedCard;

  Future<void> loadCards() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newCards = await _cardService.getCards();
      _cards = newCards;


      if (_selectedCard != null) {
        _selectedCard = _cards.firstWhere(
          (c) => c.id == _selectedCard!.id,
          orElse: () => _selectedCard!,
        );
      }
    } catch (e) {
      throw Exception("Failed to load cards: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCard(Cards card) {
    _selectedCard = card;
    notifyListeners();
  }

  void clearSelectedCard() {
    _selectedCard = null;
    notifyListeners();
  }

  Future<void> addCard(Cards newCard) async {
    try {
      await _cardService.addCard(newCard);
      await loadCards();
    } catch (e) {
      throw Exception("Failed to add card: $e");
    }
  }

  Future<void> updateCard(Cards card) async {
    try {
      await _cardService.updateCard(card);
      await loadCards();
    } catch (e) {
      throw Exception("Failed to update card: $e");
    }
  }

  Future<void> deleteCard(Cards card) async {
    try {
      await _cardService.deleteCard(card);
      await loadCards();
    } catch (e) {
      throw Exception("Failed to delete card: $e");
    }
  }
}