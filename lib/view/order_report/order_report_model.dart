// supplier_order_model.dart
class SupplierOrder {
  final int categoryId;
  final String categoryName;
  final int orderId;
  final String orderNumber;
  final String itemDescription;
  final int quantity;
  final double unitPrice;
  final double totalAmount;
  final DateTime createdAt;

  SupplierOrder({
    required this.categoryId,
    required this.categoryName,
    required this.orderId,
    required this.orderNumber,
    required this.itemDescription,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.createdAt,
  });

  factory SupplierOrder.fromJson(Map<String, dynamic> json) {
    return SupplierOrder(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      orderId: json['order_id'],
      orderNumber: json['order_number'],
      itemDescription: json['item_description'],
      quantity: json['quantity'],
      unitPrice: double.parse(json['unit_price']),
      totalAmount: double.parse(json['total_amount']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
