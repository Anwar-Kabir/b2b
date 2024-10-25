class WalletWithdrawResponse {
  String message;
  WithdrawData data;

  WalletWithdrawResponse({required this.message, required this.data});

  factory WalletWithdrawResponse.fromJson(Map<String, dynamic> json) {
    return WalletWithdrawResponse(
      message: json['message'],
      data: WithdrawData.fromJson(json['data']),
    );
  }
}

class WithdrawData {
  int id;
  int requestedBy;
  String requestedAt;
  String amount;
  String createdAt;
  String updatedAt;

  WithdrawData({
    required this.id,
    required this.requestedBy,
    required this.requestedAt,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WithdrawData.fromJson(Map<String, dynamic> json) {
    return WithdrawData(
      id: json['id'],
      requestedBy: json['requested_by'],
      requestedAt: json['requested_at'],
      amount: json['amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
