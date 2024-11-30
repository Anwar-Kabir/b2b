// screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/view/subsubcategory/sub_sub_category_controller.dart';
import 'package:isotopeit_b2b/view/subsubcategory/sub_sub_category_model.dart';
 

class SubSubCategory extends StatefulWidget {
  @override
  _SubSubCategoryState createState() => _SubSubCategoryState();
}

class _SubSubCategoryState extends State<SubSubCategory> {
  final CategoryController _controller = CategoryController();
  late Future<List<CategoryModel>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _controller.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Sub Categories'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories found.'));
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text(category.name),
                  subtitle: Text('Products: ${category.productsCount}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
