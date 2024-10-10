 



import 'package:flutter/material.dart';

class Category {
  String name;
  int serialNumber;
  int totalSubCategories;
   

  Category({
    required this.name,
    required this.serialNumber,
    required this.totalSubCategories,
     
  });
}

class CategoryForm extends StatefulWidget {
  final Category? category; // To differentiate between adding and editing
  final Function(Category) onSave;

  const CategoryForm({Key? key, this.category, required this.onSave})
      : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _serialNumber;
  late int _totalSubCategories;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // Initialize with existing category values if editing
    _name = widget.category?.name ?? '';
    _serialNumber = widget.category?.serialNumber ?? 0;
    _totalSubCategories = widget.category?.totalSubCategories ?? 0;
     
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjusts the height based on content
          children: [
            // Category Name
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Category Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            // Serial Number
            TextFormField(
              initialValue: _serialNumber.toString(),
              decoration: InputDecoration(labelText: 'Serial Number'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return 'Please enter a valid serial number';
                }
                return null;
              },
              onSaved: (value) => _serialNumber = int.parse(value!),
            ),
            // Total Sub Categories
            TextFormField(
              initialValue: _totalSubCategories.toString(),
              decoration: InputDecoration(labelText: 'Total Sub Categories'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return 'Please enter a valid number of subcategories';
                }
                return null;
              },
              onSaved: (value) => _totalSubCategories = int.parse(value!),
            ),
            // Optional Category Image
             
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final newCategory = Category(
                    name: _name,
                    serialNumber: _serialNumber,
                    totalSubCategories: _totalSubCategories,
                    
                  );
                  widget.onSave(newCategory);
                }
              },
              child: Text(
                  widget.category == null ? 'Add Category' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Category> categories = [];

  void _addOrEditCategory(Category? category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // To handle keyboard pop-up
            left: 16.0,
            right: 16.0,
          ),
          child: CategoryForm(
            category: category,
            onSave: (newCategory) {
              setState(() {
                if (category == null) {
                  categories.add(newCategory);
                } else {
                  // Update existing category
                  int index = categories.indexOf(category);
                  categories[index] = newCategory;
                }
              });
              Navigator.pop(context); // Close the modal after saving
            },
          ),
        );
      },
    );
  }

  void _deleteCategory(Category category) {
    setState(() {
      categories.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addOrEditCategory(null),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                
                child:  Text((index + 1).toString())
                     // Show index if no image
              ),
              title: Text(category.name),
              subtitle: Text(
                'Serial: ${category.serialNumber}, Sub Categories: ${category.totalSubCategories}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                  CircleAvatar(
                    backgroundColor:
                        Colors.blue.withOpacity(0.2), // Light blue background
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _addOrEditCategory(category),
                    ),
                  ),
                  SizedBox(width: 8), // Add some space between buttons

                  // Delete button with circular background
                  CircleAvatar(
                    backgroundColor:
                        Colors.red.withOpacity(0.2), // Light red background
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCategory(category),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
