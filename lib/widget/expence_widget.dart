import 'package:bank/widget/popups/category_pop_up.dart';
import 'package:bank/widget/popups/create_category_pop_up.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ExpenceWidget extends StatefulWidget {
  const ExpenceWidget({super.key});

  @override
  State<ExpenceWidget> createState() => _ExpenceWidgetState();
}

class _ExpenceWidgetState extends State<ExpenceWidget> {
  String? selectedCategoryName;
  String? selectedCategoryEmoji;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 188, 0, 8),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Amount',
                    contentPadding: const EdgeInsets.all(30),
                  ),
                ),
                const SizedBox(height: 20),

                // BUTTON TO OPEN CATEGORY POPUP AS A BOTTOM SHEET
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return CategoryPopUp(
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategoryName = category.category_name;
                              selectedCategoryEmoji = category.emoji;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    selectedCategoryName != null
                        ? "$selectedCategoryEmoji  $selectedCategoryName"
                        : 'Select Your Category',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateCategoryPopUp(),
                    );
                  },
                  child: DottedBorder(
                    color: Colors.blue,
                    strokeWidth: 2,
                    dashPattern: [6, 4],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(16),
                    child: SizedBox(
                      height: 70,
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    // Add your save logic here
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
