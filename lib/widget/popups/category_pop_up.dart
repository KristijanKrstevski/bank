import 'package:flutter/material.dart';
import 'package:bank/model/expenses_category.dart';
import 'package:bank/service/expenses_category_service.dart';

class CategoryPopUp extends StatefulWidget {
  final Function(ExpensesCategory) onCategorySelected;

  const CategoryPopUp({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  State<CategoryPopUp> createState() => _CategoryPopUpState();
}

class _CategoryPopUpState extends State<CategoryPopUp> {
  late Future<List<ExpensesCategory>> _categoriesFuture;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    setState(() {
      isLoading = true;
    });

    _categoriesFuture = ExpencesCategoryService().getExpensesCategory();
    
    _categoriesFuture.then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Choose your category!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loading spinner
              : FutureBuilder<List<ExpensesCategory>>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No categories found. Please create a category.'));
                    }

                    final categories = snapshot.data!;
                    return SizedBox(
                      height: 300, // Set height for the list view
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ListTile(
                            leading: Text(category.emoji),
                            title: Text(category.category_name),
                            onTap: () {
                              widget.onCategorySelected(category);
                              Navigator.pop(context, category);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
