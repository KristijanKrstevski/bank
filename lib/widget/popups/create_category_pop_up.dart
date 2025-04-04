

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bank/model/expenses_category.dart';
import 'package:bank/providers/expences_category_provider.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateCategoryPopUp extends StatefulWidget {
  const CreateCategoryPopUp({super.key});

  @override
  State<CreateCategoryPopUp> createState() => _CreateCategoryPopUpState();
}

class _CreateCategoryPopUpState extends State<CreateCategoryPopUp> {
  final TextEditingController _categoryController = TextEditingController();
  String _selectedEmoji = "😀"; 
 final SupabaseClient _supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<ExpencesCategoryProvider>(context);
 final userId = _supabase.auth.currentUser?.id;
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 10, right: 10),
      title: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.center,
              child: Text('Create your category!'),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.grey, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _selectedEmoji,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showEmojiPicker(),
                  child: const Text("Pick Emoji"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              labelText: "Category Name",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            String categoryName = _categoryController.text;
            if (categoryName.isEmpty) return;

            ExpensesCategory newCategory = ExpensesCategory(
              user_id: userId.toString(),
              category_name: categoryName,
              emoji: _selectedEmoji,
              id: -1,
            );

            await categoryProvider.addExpenceCategory(newCategory);

            Navigator.pop(context);
          },
          child: categoryProvider.isLoading
              ? const CircularProgressIndicator()
              : const Text("Save"),
        ),
      ],
    );
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              setState(() {
                _selectedEmoji = emoji.emoji;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
