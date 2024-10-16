import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final int stock; // current stock
  final double price;
  final bool isOutOfStock;

  Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
  }) : isOutOfStock = stock == 0;

  bool get isLowStock => stock < 5 && stock > 0;
}

class Sale {
  final String productId;
  final double amount;
  final DateTime date;

  Sale({
    required this.productId,
    required this.amount,
    required this.date,
  });
}

class Order {
  final String id;
  final String status; // completed, pending, canceled
  final double totalAmount;
  final DateTime date;

  Order({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.date,
  });
}

class SalesReportManager {
  List<Sale> sales;
  List<Product> products;

  SalesReportManager({required this.sales, required this.products});

  // Total Sales
  double getTotalSales() {
    return sales.fold(0.0, (sum, sale) => sum + sale.amount);
  }

  // Sales by Product
  double getSalesByProduct(String productId) {
    return sales
        .where((sale) => sale.productId == productId)
        .fold(0.0, (sum, sale) => sum + sale.amount);
  }

  // Sales by Date Range
  double getSalesByDateRange(DateTime startDate, DateTime endDate) {
    return sales
        .where((sale) =>
            sale.date.isAfter(startDate) && sale.date.isBefore(endDate))
        .fold(0.0, (sum, sale) => sum + sale.amount);
  }

  // Generate sales summary
  void generateSalesReport() {
    double totalSales = getTotalSales();
    print("Total Sales: \$$totalSales");

    for (Product product in products) {
      double productSales = getSalesByProduct(product.id);
      print("Sales for ${product.name}: \$$productSales");
    }
  }
}

class StockReportManager {
  List<Product> products;

  StockReportManager({required this.products});

  // Get stock summary
  void generateStockSummary() {
    int inStock = products.where((product) => product.stock > 0).length;
    int outOfStock = products.where((product) => product.isOutOfStock).length;
    int lowStock = products.where((product) => product.isLowStock).length;

    print("In Stock: $inStock");
    print("Out of Stock: $outOfStock");
    print("Low Stock: $lowStock");
  }
}

class OrderReportManager {
  List<Order> orders;

  OrderReportManager({required this.orders});

  // Get orders by status
  List<Order> getOrdersByStatus(String status) {
    return orders.where((order) => order.status == status).toList();
  }

  // Generate Order Summary
  void generateOrderReport() {
    List<Order> completedOrders = getOrdersByStatus('completed');
    List<Order> pendingOrders = getOrdersByStatus('pending');
    List<Order> canceledOrders = getOrdersByStatus('canceled');

    print("Completed Orders: ${completedOrders.length}");
    print("Pending Orders: ${pendingOrders.length}");
    print("Canceled Orders: ${canceledOrders.length}");
  }
}

class ReportManagerPage extends StatefulWidget {
  const ReportManagerPage({super.key});

  @override
  _ReportManagerPageState createState() => _ReportManagerPageState();
}

class _ReportManagerPageState extends State<ReportManagerPage> {
  // Dummy Data
  List<Sale> sales = [
    Sale(
        productId: '1',
        amount: 150.0,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Sale(
        productId: '2',
        amount: 50.0,
        date: DateTime.now().subtract(const Duration(days: 5))),
  ];

  List<Product> products = [
    Product(id: '1', name: 'Product A', stock: 10, price: 100),
    Product(id: '2', name: 'Product B', stock: 0, price: 50),
  ];

  List<Order> orders = [
    Order(
        id: '1',
        status: 'completed',
        totalAmount: 100.0,
        date: DateTime.now().subtract(const Duration(days: 1))),
    Order(id: '2', status: 'pending', totalAmount: 50.0, date: DateTime.now()),
    Order(
        id: '3',
        status: 'canceled',
        totalAmount: 70.0,
        date: DateTime.now().subtract(const Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    SalesReportManager salesManager =
        SalesReportManager(sales: sales, products: products);
    StockReportManager stockManager = StockReportManager(products: products);
    OrderReportManager orderManager = OrderReportManager(orders: orders);

    return Scaffold(
      appBar: AppBar(title: const Text('Report Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sales Reports',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                salesManager.generateSalesReport();
              },
              child: const Text('Generate Sales Report'),
            ),
            const SizedBox(height: 20),
            const Text('Stock Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                stockManager.generateStockSummary();
              },
              child: const Text('Generate Stock Summary'),
            ),
            const SizedBox(height: 20),
            const Text('Order Reports',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                orderManager.generateOrderReport();
              },
              child: const Text('Generate Order Report'),
            ),
          ],
        ),
      ),
    );
  }
}
