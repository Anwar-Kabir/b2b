import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/inventory/add_inventory/add_inventory.dart';
import 'package:isotopeit_b2b/view/inventory/inventrory/inventory_controller.dart';
import 'package:isotopeit_b2b/view/inventory/inventory_details/inventory_product_details.dart';
import 'package:isotopeit_b2b/view/inventory/inventrory/inventory_model.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  int _selectedIndex = 0;
  final InventoryActiveController _controller =
      Get.put(InventoryActiveController());

  final List<String> tabs = [
    'Active',
    'Inactive',
    'In Stock',
    'Out of Stock',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const AddInventoryPage(),
                  transition: Transition.rightToLeftWithFade);
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedIndex == index
                          ? AppColor.primaryColor
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      side: BorderSide(
                        color: _selectedIndex == index
                            ? AppColor.primaryColor
                            : Colors.grey,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
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
    return Obx(() {
      if (_controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      switch (_selectedIndex) {
        case 0:
          return _buildProductList(
              _controller.activeProducts, 'No Active Products Found');
        case 1:
          return _buildProductList(
              _controller.inactiveProducts, 'No Inactive Products Found');
        case 2:
          return _buildProductList(
              _controller.inStockProducts, 'No In Stock Products Found');
        case 3:
        default:
          return _buildProductList(
              _controller.outOfStockProducts, 'No Out of Stock Products Found');
      }
    });
  }

  Widget _buildProductList(
      RxList<InventoryActiveModel> products, String emptyMessage) {
    if (products.isEmpty) {
      return Center(
          child: Text(emptyMessage,
              style: TextStyle(fontSize: 20, color: Colors.grey)));
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final InventoryActiveModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var id = product.id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to( InvenProductDetails(inventoryId: id),
              transition: Transition.rightToLeftWithFade);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(product.featureImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      
                      Text(
                        'Price: \$${double.parse(product.salePrice).toStringAsFixed(2) }',
                        style: const TextStyle(color: AppColor.primaryColor),
                      ),
                      Text('Net Price: \$${product.netPrice}'),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
