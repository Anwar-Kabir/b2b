 
       


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/inventory.dart/add_inventory.dart';
import 'package:isotopeit_b2b/view/inventory.dart/inven_product_details.dart';

class ProductManager extends StatefulWidget {
  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  int _selectedIndex = 0; // Track the selected button

  final List<String> tabs = [
    'Active',
    'Inactive',
    'In Stock',
    'Out of stock',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management', style: TextStyle(color: Colors.white),
        ),
         backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddInventoryPage());
              },
              icon: const Icon(Icons.add, color: Colors.white)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(tabs.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: 
                  
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedIndex == index
                          ? AppColor
                              .primaryColor // Highlight the selected button
                          : Colors.white, // Unselected button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      side: BorderSide(
                        color: _selectedIndex == index
                            ? AppColor.primaryColor
                            : Colors.grey, // Border color
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16), // Add horizontal padding
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Make the row size to fit the button text
                      children: [
                        Text(
                          tabs[index],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors
                                    .black, // Text color based on selection
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                
                    
                  
                            
                            
                            
                );
              }),
            ),
          ),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return ProductTab(
          title: 'Featured Items',
          products: activeListings, // Define this list accordingly
        );
      case 1:
        return ProductTab(
          title: 'Most Recent',
          products: inactiveListings, // Define this list accordingly
        );
        case 2:
        return ProductTab(
          title: 'Most Recent',
          products: inactiveListings2, // Define this list accordingly
        );
      case 3:
      default:
        return ProductTab(
          title: 'New Arrivals',
          products: inStockListings, // Define this list accordingly
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
      child: 
      
      

      GestureDetector(
        onTap: (){
          Get.to(ProductDetailsScreen());
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns items to the top
                children: <Widget>[
                  // Image on the left (leading)
                  Container(
                    width: 80, // Set the width of the image
                    height: 80, // Set the height of the image
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded image corners
                       image: DecorationImage(
                        image: AssetImage(
                            'assets/abc.jpg'), // Local asset image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
        
                  SizedBox(width: 12), // Space between image and text
        
                  // Product details
                  Expanded(
                    // Makes sure text occupies the remaining space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Product name
                        Text(
                          product['productName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
        
                        SizedBox(
                            height: 6), // Space between product name and price
        
                        // Price details
                        Text(
                          'Price: \$${product['price']}',
                          style: TextStyle(color: AppColor.primaryColor),
                        ),
                        Text('Net Price: \$${product['netPrice']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      )
    );
  }
}

// Sample data for each tab
final List<Map<String, dynamic>> activeListings = [
  {
    'sku': '10101',
    'productName': 'Korola (Bitter Gourd)',
    'attributes': 'Small - Local - Green',
    'price': 85.00,
    'netPrice': 92.65,
    'quantity': 41,
    'moq': 1,
  },
];

final List<Map<String, dynamic>> inactiveListings = [
  {
    'sku': '10202',
    'productName': 'Shoes',
    'attributes': 'Large - Black',
    'price': 100.00,
    'netPrice': 110.00,
    'quantity': 0,
    'moq': 2,
  },
];

final List<Map<String, dynamic>> inactiveListings2 = [
  {
    'sku': '10202',
    'productName': 'Shoes',
    'attributes': 'Large - Black',
    'price': 100.00,
    'netPrice': 110.00,
    'quantity': 0,
    'moq': 2,
  },
];

final List<Map<String, dynamic>> inStockListings = [
  {
    'sku': '10303',
    'productName': 'T-shirt',
    'attributes': 'Medium - White',
    'price': 25.00,
    'netPrice': 27.50,
    'quantity': 50,
    'moq': 5,
  },
];
      




      