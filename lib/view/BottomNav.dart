import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_list/attribute.dart';
import 'package:isotopeit_b2b/view/auction/auction.dart';
import 'package:isotopeit_b2b/view/banner/banner/banner.dart';
import 'package:isotopeit_b2b/view/category&tag/category_and_tag.dart';
import 'package:isotopeit_b2b/view/courier/courier_list/courier.dart';
import 'package:isotopeit_b2b/view/home/home.dart';
import 'package:isotopeit_b2b/view/inventory/inventory.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';
import 'package:isotopeit_b2b/view/order/orderlist/order_list.dart';
import 'package:isotopeit_b2b/view/product/productlist/product_list.dart';
import 'package:isotopeit_b2b/view/report/report.dart';
import 'package:isotopeit_b2b/view/settings/settings.dart';
import 'package:isotopeit_b2b/view/shopsettings/shop_settings.dart';
import 'package:isotopeit_b2b/view/wallet/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  final LoginController loginController = Get.put(LoginController());

  int _selectedIndex = 0;

  // Screens for each tab
  static final List<Widget> _pages = <Widget>[
       HomePage(),
    OrderListScreen(),
    const Wallet(),
    const ProductManager(),
    const Settings(),
  ];

  // Titles for each tab
  static const List<String?> _titles = <String?>[
    'Home',
    null,
    null,
    null,
    'Settings',
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Load user info when the widget initializes
    loginController.loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    //Load user info if not already loaded

    return Scaffold(
      appBar: _titles[_selectedIndex] != null
          ? AppBar(
              title: Text(
                _titles[_selectedIndex]!,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColor.primaryColor.withOpacity(0.7),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            )
          : null,
      drawer: Drawer(
        child: Obx(() {
          if (loginController.userInfo.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          'https://www.w3schools.com/w3images/avatar2.png',
                        ),
                      ),
                      const SizedBox(height: 10),
                      //_buildTableRow('Name', loginController.userInfo['name']),
                      //_buildTableRow('Email', loginController.userInfo['email']),
                      Text(
                        '${loginController.userInfo['name'] ?? 'Unknown Name'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${loginController.userInfo['email'] ?? 'Unknown Email'}',
                        style: const TextStyle(
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
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Attribute'),
                  onTap: () {
                    Get.to(
                      AttributeListPage(),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Inventory'),
                  onTap: () {
                    Get.to(
                      const ProductManager(),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shop),
                  title: const Text('Product'),
                  onTap: () {
                    Get.to(ProductListCard(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Category and Tag'),
                  onTap: () {
                    Get.to(CategoryTagPage(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.accessible),
                  title: const Text('Order'),
                  onTap: () {
                    Get.to(OrderListScreen(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.accessible),
                  title: const Text('Courier'),
                  onTap: () {
                    Get.to(  Courier(),
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
                    Get.to(BannerManager(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.currency_exchange),
                  title: const Text('Wallet'),
                  onTap: () {
                    Get.to(const Wallet(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Auction'),
                  onTap: () {
                    Get.to(const AuctionPage(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shop_rounded),
                  title: const Text('Shop Settings'),
                  onTap: () {
                    Get.to(const ShopSettingsPage(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.note),
                  title: const Text('Reports'),
                  onTap: () {
                    Get.to(const ReportManagerPage(),
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
            );
          }
        }),
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
