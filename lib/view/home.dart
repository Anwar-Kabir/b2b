import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/attributes/attribute.dart';
import 'package:isotopeit_b2b/view/auction/auction.dart';
import 'package:isotopeit_b2b/view/category/category.dart';
import 'package:isotopeit_b2b/view/courier/courier.dart';
import 'package:isotopeit_b2b/view/inventory.dart/inventory.dart';
import 'package:isotopeit_b2b/view/order/order.dart';
import 'package:isotopeit_b2b/view/product/product.dart';
import 'package:isotopeit_b2b/view/report/report.dart';
import 'package:isotopeit_b2b/view/settings/settings.dart';
import 'package:isotopeit_b2b/view/banner/banner.dart';
import 'package:isotopeit_b2b/view/shopsettings/shop_settings.dart';
import 'package:isotopeit_b2b/view/wallet/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  // Screens for each tab
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home Page')),
    Center(child: Text('Auction Page')),
    Center(child: Text('Wallet Page')),
    Center(child: Text('Inventory Page')),
    // Center(child: Text('Profile Page')),
    Settings(),
  ];

  // Titles for each tab
  static const List<String> _titles = <String>[
    'Home',
    'Order',
    'Wallet',
    'Inventory',
    'Settings',
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      'https://www.w3schools.com/w3images/avatar2.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Attribute Management'),
              onTap: () {
                Get.to(SizeColorManager());
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Inventory Management'),
              onTap: () {
                Get.to(ProductManager(),
                    transition: Transition.leftToRightWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Product Management'),
              onTap: () {
                Get.to(ProductListScreen(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Category and Tag'),
              onTap: () {
                Get.to(CategoryListPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessible),
              title: const Text('Order Management'),
              onTap: () {
                Get.to(OrderListScreen(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessible),
              title: const Text('Courier'),
              onTap: () {
                Get.to(const Courier(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Sub-order and Courier'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                // Add logout functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Shop Banner'),
              onTap: () {
                Get.to(BannerManager());
              },
            ),
            ListTile(
              leading: const Icon(Icons.currency_exchange),
              title: const Text('Wallet Management'),
              onTap: () {
                Get.to(WalletManager(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Auction Management'),
              onTap: () {
                Get.to(AuctionManager(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_rounded),
              title: const Text('Shop Settings'),
              onTap: () {
                Get.to(ShopSettingsPage(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Reports'),
              onTap: () {
                Get.to(ReportManagerPage(),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('App Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                // Add logout functionality here
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // to show all tabs
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.primaryColor, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        onTap: _onItemTapped,
      ),
    );
  }
}
