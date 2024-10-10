import 'package:flutter/material.dart';

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

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
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
    products.add(Product(
        name: 'Product 3',
        price: 200.0,
        imageUrl: 'https://via.placeholder.com/150',
        stockStatus: 'Active'));
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

  // Navigate to product details page
  void viewProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              child: ListTile(
                leading: Image.network(product.imageUrl),
                title: Text('${product.name}'),
                subtitle: Text(
                  '\$${product.price} - ${product.stockStatus}',
                  style: TextStyle(color: getStockColor(product.stockStatus)),
                ),
                onTap: () =>
                    viewProductDetails(product), // Navigate to detail view
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Product Name: ${product.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${product.price}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Stock Status: ${product.stockStatus}',
              style: TextStyle(
                fontSize: 18,
                color: getStockColor(product.stockStatus),
              ),
            ),
            const SizedBox(height: 20),
             
          ],
        ),
      ),
    );
  }

  // Method to return color based on stock status (same as in ProductListScreen)
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
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductListScreen(),
  ));
}
