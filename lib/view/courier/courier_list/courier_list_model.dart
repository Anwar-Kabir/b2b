class CourierListResponse {
  final bool success;
  final List<CourierData> data;
  final String message;

  CourierListResponse(
      {required this.success, required this.data, required this.message});

  factory CourierListResponse.fromJson(Map<String, dynamic> json) {
    return CourierListResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => CourierData.fromJson(item))
          .toList(),
      message: json['message'] ?? '',
    );
  }
}

class CourierData {
  final int id;
  final String trackNo;
  final String orderNumber;
  final List<OrderItem> orderItems;
  final String createdAt;

  CourierData({
    required this.id,
    required this.trackNo,
    required this.orderNumber,
    required this.orderItems,
    required this.createdAt,
  });

  factory CourierData.fromJson(Map<String, dynamic> json) {
    return CourierData(
      id: json['id'],
      trackNo: json['track_no'],
      orderNumber: json['order_number'],
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      createdAt: json['created_at'],
    );
  }
}

class OrderItem {
  final String itemName;
  final int quantity;
  final String price;

  OrderItem({
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemName: json['item_name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
