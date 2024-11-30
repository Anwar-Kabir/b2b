class OrderModel {
  String status;
  OrderData data;

  OrderModel({required this.status, required this.data});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
  int id;
  String ? orderNumber;
  int customerId;
  int? billingAddressId;
  int? shippingAddressId;
  int itemCount;
  String ? total;
  String ? discount;
  String ? taxes;
  String ? deliveryCharge;
  String ? grandTotal;
  String ? totalPaymentAmount;
  String ? customerEmail;
  String ? customerPhoneNumber;
  bool paymentStatus;
  bool orderStatus;
  String? paymentMethod;
  String ? buyerNote;
  List<OrderItem> items;

  OrderData({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    this.billingAddressId,
    this.shippingAddressId,
    required this.itemCount,
    required this.total,
    required this.discount,
    required this.taxes,
    required this.deliveryCharge,
    required this.grandTotal,
    required this.totalPaymentAmount,
    required this.customerEmail,
    required this.customerPhoneNumber,
    required this.paymentStatus,
    required this.orderStatus,
    this.paymentMethod,
    required this.buyerNote,
    required this.items,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      orderNumber: json['order_number'],
      customerId: json['customer_id'] ?? 0,
      billingAddressId: json['billing_address_id'],
      shippingAddressId: json['shipping_address_id'],
      itemCount: json['item_count'] ?? 0,
      total: json['total'],
      discount: json['discount'],
      taxes: json['taxes'],
      deliveryCharge: json['delivery_charge'],
      grandTotal: json['grand_total'],
      totalPaymentAmount: json['total_payment_amount'],
      customerEmail: json['customer_email'],
      customerPhoneNumber: json['customer_phone_number'],
      // Convert 1/0 to boolean
      paymentStatus: json['payment_status'] == 1,
      orderStatus: json['order_status'] == 1,
      paymentMethod: json['payment_method'],
      buyerNote: json['buyer_note'] ?? '',
      items: List<OrderItem>.from(
          json['items'].map((item) => OrderItem.fromJson(item))),
    );
  }
}

class OrderItem {
  int id;
  String itemDescription;
  int quantity;
  String unitPrice;
  String totalAmount;

  OrderItem({
    required this.id,
    required this.itemDescription,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      itemDescription: json['item_description'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      totalAmount: json['total_amount'],
    );
  }
}
