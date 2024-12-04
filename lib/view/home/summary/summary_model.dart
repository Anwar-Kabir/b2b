class Summary {
  final int shopId;
  final int total;

  Summary({required this.shopId, required this.total});

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      shopId: json['shop_id'],
      total: json['total_orders'] ??
          json['total_inventory'] ??
          json['total_product'] ??
          json['total_courier'],
    );
  }
}
