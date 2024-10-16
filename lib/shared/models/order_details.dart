class OrderDetails {
  final String? status;
  final OrderItem? data;

  OrderDetails({this.status, this.data});

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      status: json['status'] as String?,
      data: json['data'] != null
          ? OrderItem.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class OrderItem {
  final List<dynamic>? order;
  final List<dynamic>? filteredOrderItems;

  OrderItem({
    this.order,
    this.filteredOrderItems,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      order: json['order'] as List<dynamic>?,
      filteredOrderItems: json['filteredOrderItems'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'filteredOrderItems': filteredOrderItems,
    };
  }
}
