class PickupAddress {
  final int id;
  final String text;

  PickupAddress({required this.id, required this.text});

  factory PickupAddress.fromJson(Map<String, dynamic> json) {
    return PickupAddress(
      id: json['id'],
      text: json['text'],
    );
  }
}
