// courier_detail_model.dart
import 'dart:convert';

class CourierDetailResponse {
  final CourierData courier;

  CourierDetailResponse({required this.courier});

  factory CourierDetailResponse.fromJson(Map<String, dynamic> json) {
    return CourierDetailResponse(
      courier: CourierData.fromJson(json['courier']),
    );
  }
}

class CourierData {
  final int id;
  final String trackNo;
  final String orderNumber;
  final String customerName;
  final String paymentAmount;
  final String due;
  final String vehicleCharge;
  final String loadUnloadCharge;
  final String grandTotal;
  final String note;
  final String pickupDate;
  final String deliveryDate;
  final String createdAt;
  final String createdBy;
  final String status;
  final int progress;
  final List<OrderItem> orderItems;

  CourierData({
    required this.id,
    required this.trackNo,
    required this.orderNumber,
    required this.customerName,
    required this.paymentAmount,
    required this.due,
    required this.vehicleCharge,
    required this.loadUnloadCharge,
    required this.grandTotal,
    required this.note,
    required this.pickupDate,
    required this.deliveryDate,
    required this.createdAt,
    required this.createdBy,
    required this.status,
    required this.progress,
    required this.orderItems,
  });

  factory CourierData.fromJson(Map<String, dynamic> json) {
    var itemsList = json['order_items'] as List;
    List<OrderItem> orderItems =
        itemsList.map((i) => OrderItem.fromJson(i)).toList();

    return CourierData(
      id: json['id'],
      trackNo: json['track_no'],
      orderNumber: json['order_number'],
      customerName: json['customer_name'],
      paymentAmount: json['payment_amount'],
      due: json['due'],
      vehicleCharge: json['vehicle_charge'],
      loadUnloadCharge: json['load_unload_charge'],
      grandTotal: json['grand_total'],
      note: json['note'],
      pickupDate: json['pickup_date'],
      deliveryDate: json['delivery_date'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      status: json['status'],
      progress: json['progress'],
      orderItems: orderItems,
    );
  }
}

class OrderItem {
  final String itemDescription;
  final int quantity;
  final String unitPrice;
  final String totalPrice;
  final String imageUrl;

  OrderItem({
    required this.itemDescription,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemDescription: json['item_description'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      totalPrice: json['total_price'],
      imageUrl: json['image_url'],
    );
  }
}
