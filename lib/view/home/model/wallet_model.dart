class Wallet {
  //final int userId;
  final String balance;

  Wallet({ required this.balance});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      //userId: json['user_id'],
      balance: json['balance'],
    );
  }
}
