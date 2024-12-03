class ApproveResponse {
  final String status;
  final String message;

  ApproveResponse({required this.status, required this.message});

  factory ApproveResponse.fromJson(Map<String, dynamic> json) {
    return ApproveResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
