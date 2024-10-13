import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory  Details', style: TextStyle(color: Colors.white),
        ),
         backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.asset(
                  'assets/abc.jpg', // replace with your image URL or asset
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(height: 10),

              // Image selection options (horizontal scrollable)
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildImageSelection('assets/abc.jpg'),
                    _buildImageSelection('assets/abc.jpg'),
                    _buildImageSelection('assets/abc.jpg'),
                    _buildImageSelection('assets/abc.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Product Title, Rating, and Price
              Text(
                'Fresh Broccoli',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 5),
                  Text('(5.0)', style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '\$12.22',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Wishlist and Buy Now Buttons
             
              SizedBox(height: 20),

              // Additional Details
              Text(
                'Additional Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildDetailRow('Availability', 'In Stock'),
              _buildDetailRow('Brand', 'Green Farms'),
              _buildDetailRow('Category', 'Vegetables'),
              _buildDetailRow('Size/Weight', '500 g'),
              _buildDetailRow('SKU', 'SKU12346'),
              _buildDetailRow('Ingredients', 'Broccoli'),
              SizedBox(height: 20),

              // Description Section
              Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Fresh Broccoli is a nutritious vegetable known for its high content of vitamins, minerals, and fiber...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        
      ),
     bottomNavigationBar:  Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Edit'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text('Delete', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
     ),
              
      
    );
  }

  // Widget to build image selection (thumbnails)
  Widget _buildImageSelection(String imagepath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(imagepath, fit: BoxFit.cover),
      ),
    );
  }

  // Widget to build key-value rows for product details
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          SizedBox(width: 15,),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
