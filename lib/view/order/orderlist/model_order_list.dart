class Order {
  int id;
  String orderNumber;
  String customerEmail;
  String customerPhoneNumber;
  int itemCount;
  String total;
  String grandTotal;
  int orderStatus;
  int paymentStatus;
  DateTime createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customerEmail,
    required this.customerPhoneNumber,
    required this.itemCount,
    required this.total,
    required this.grandTotal,
    required this.orderStatus,
    required this.paymentStatus,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      customerEmail: json['customer_email'],
      customerPhoneNumber: json['customer_phone_number'],
      itemCount: json['item_count'],
      total: json['total'],
      grandTotal: json['grand_total'],
      orderStatus: json['order_status'],
      paymentStatus: json['payment_status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
