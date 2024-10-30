class WalletWithdrawRequest {
  final int id;
  final String amount;
  final int requestedBy;
  final dynamic requestedAt;
  final int status;

  WalletWithdrawRequest({
    required this.id,
    required this.amount,
    required this.requestedBy,
    required this.requestedAt,
    required this.status,
  });

  factory WalletWithdrawRequest.fromJson(Map<String, dynamic> json) {
    return WalletWithdrawRequest(
      id: json['id'],
      amount: json['amount'],
      requestedBy: json['requested_by'],
      requestedAt: json['requested_at'],
      status: json['status'],
    );
  }
}
