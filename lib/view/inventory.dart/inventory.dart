


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/inventory.dart/add_inventory.dart';

class Product {
  String name;
  double price;
  String imageUrl;
  String stockStatus;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.stockStatus,
  });
}

class ProductManager extends StatefulWidget {
  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    // Adding sample products for demo
    products.add(Product(
        name: 'Product 1',
        price: 100.0,
        imageUrl: 'https://via.placeholder.com/150',
        stockStatus: 'In Stock'));
    products.add(Product(
        name: 'Product 2',
        price: 150.0,
        imageUrl: 'https://via.placeholder.com/150',
        stockStatus: 'Out of Stock'));
  }

  // Show modal to add/edit product
  void showProductModal({Product? product, int? index}) {
    final TextEditingController nameController =
        TextEditingController(text: product?.name);
    final TextEditingController priceController = TextEditingController(
        text: product != null ? product!.price.toString() : '');

    String stockStatus = product?.stockStatus ?? 'In Stock';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: stockStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    stockStatus = newValue!;
                  });
                },
                items: <String>[
                  'Active',
                  'Inactive',
                  'In Stock',
                  'Out of Stock'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    String newName = nameController.text;
                    double? newPrice = double.tryParse(priceController.text);
                    if (newName.isNotEmpty && newPrice != null) {
                      setState(() {
                        if (index != null) {
                          products[index] = Product(
                            name: newName,
                            price: newPrice,
                            imageUrl:
                                'https://via.placeholder.com/150', // Placeholder image
                            stockStatus: stockStatus,
                          );
                        } else {
                          products.add(Product(
                            name: newName,
                            price: newPrice,
                            imageUrl:
                                'https://via.placeholder.com/150', // Placeholder image
                            stockStatus: stockStatus,
                          ));
                        }
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please enter valid product details')),
                      );
                    }
                  },
                  child: Text(index != null ? 'Update Product' : 'Add Product'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Delete product
  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  // Method to return color based on stock status
  Color getStockColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.grey;
      case 'In Stock':
        return Colors.blue;
      case 'Out of Stock':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

   int _selectedIndex = 0; // Track the selected tab

  final List<String> tabs = [
    'Active',
    'Inactive',
    'Out of Stock',
    'In Stock',
  ];

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
        actions: [IconButton(onPressed: (){
          Get.to(  AddInventoryPage(), transition: Transition.leftToRight);
        }, icon: const Icon(Icons.add, color: AppColor.primaryColor,))],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CupertinoSegmentedControl<int>(
            children: {
              0: Text(tabs[0], style: TextStyle(color: _selectedIndex == 0 ? Colors.white : Colors.black)),
              1: Text(tabs[1], style: TextStyle(color: _selectedIndex == 1 ? Colors.white : Colors.black)),
              2: Text(tabs[2], style: TextStyle(color: _selectedIndex == 2 ? Colors.white : Colors.black)),
              3: Text(tabs[3], style: TextStyle(color: _selectedIndex == 3 ? Colors.white : Colors.black)),
            },
            onValueChanged: (int? value) {
              setState(() {
                _selectedIndex = value!;
              });
            },
            groupValue: _selectedIndex,
            selectedColor: Colors.green,
            unselectedColor: Colors.transparent,
          ),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    ));
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return ProductTab(
          title: 'Active Listings',
          products: activeListings,
        );
      case 1:
        return ProductTab(
          title: 'Inactive Listings',
          products: inactiveListings,
        );
      case 2:
        return ProductTab(
          title: 'Out of Stock Listings',
          products: outOfStockListings,
        );
      case 3:
      default:
        return ProductTab(
          title: 'In Stock Listings',
          products: inStockListings,
        );
    }
  }
}

class ProductTab extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;

  ProductTab({required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product['productName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 6),
              Text('SKU: ${product['sku']}'),
              Text('Attributes: ${product['attributes']}'),
              Text('Price: \$${product['price']}'),
              Text('Net Price: \$${product['netPrice']}'),
              Text('Quantity: ${product['quantity']}'),
              Text('MOQ: ${product['moq']}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(CupertinoIcons.eye, color: Colors.green),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.pencil, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.trash, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sample data for each tab
final List<Map<String, dynamic>> activeListings = [
  {
    'sku': '6635545772',
    'productName': 'Korola (Bitter Gourd)',
    'attributes': 'Small - Local - Green',
    'price': '85.00',
    'netPrice': '92.65',
    'quantity': '41',
    'moq': '1',
  },
  {
    'sku': '112534',
    'productName': 'Begun (Brinjal)',
    'attributes': 'Medium - Local - Blue',
    'price': '60.00',
    'netPrice': '65.40',
    'quantity': '113',
    'moq': '1',
  },
];

final List<Map<String, dynamic>> inactiveListings = [
  {
    'sku': '124553',
    'productName': 'Kacha Morich (Green Chilly)',
    'attributes': 'Large - Local - Green',
    'price': '240.00',
    'netPrice': '261.60',
    'quantity': '0',
    'moq': '15',
  },
];

final List<Map<String, dynamic>> outOfStockListings = [
  {
    'sku': '225344',
    'productName': 'Dhonia pata (Coriander Leaf)',
    'attributes': 'Small - Medium - Green',
    'price': '200.00',
    'netPrice': '218.00',
    'quantity': '0',
    'moq': '15',
  },
];

final List<Map<String, dynamic>> inStockListings = [
  {
    'sku': '29014',
    'productName': 'Tomato',
    'attributes': 'Large - Local - Red',
    'price': '160.00',
    'netPrice': '174.40',
    'quantity': '82',
    'moq': '1',
  },
];
    
