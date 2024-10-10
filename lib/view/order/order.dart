 import 'package:flutter/material.dart';

class Order {
  String orderId;
  String customerName;
  double amount;
  String orderStatus;
  DateTime date;

  Order({
    required this.orderId,
    required this.customerName,
    required this.amount,
    required this.orderStatus,
    required this.date,
  });
}

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();

    // Adding sample orders for demo purposes
    orders.add(Order(
        orderId: 'ORD123',
        customerName: 'John Doe',
        amount: 250.00,
        orderStatus: 'Shipped',
        date: DateTime.now().subtract(Duration(days: 1))));
    orders.add(Order(
        orderId: 'ORD124',
        customerName: 'Jane Smith',
        amount: 150.00,
        orderStatus: 'Processing',
        date: DateTime.now().subtract(Duration(days: 2))));
    orders.add(Order(
        orderId: 'ORD125',
        customerName: 'Alex Johnson',
        amount: 300.00,
        orderStatus: 'Delivered',
        date: DateTime.now().subtract(Duration(days: 3))));
  }

  // Navigate to the order detail screen
  void viewOrderDetails(Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(order: order),
      ),
    );
  }

  // Method to return color based on order status
  Color getOrderStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              child: ListTile(
                title: Text('Order ID: ${order.orderId}'),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${order.customerName} - ',
                        style: TextStyle(color: Colors.black87),
                      ),
                      TextSpan(
                        text: '\$${order.amount} - ',
                        style: TextStyle(color: Colors.black87),
                      ),
                      TextSpan(
                        text: '${order.orderStatus}',
                        style: TextStyle(
                          color: getOrderStatusColor(
                              order.orderStatus), // Applying color here
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () =>
                    viewOrderDetails(order), // Navigate to order details
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.orderId}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Customer Name: ${order.customerName}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Order Amount: \$${order.amount}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Order Status: ${order.orderStatus}',
              style: TextStyle(
                fontSize: 18,
                color: getOrderStatusColor(order.orderStatus),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Order Date: ${order.date.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
             
          ],
        ),
      ),
    );
  }

  // Method to return color based on order status
  Color getOrderStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
