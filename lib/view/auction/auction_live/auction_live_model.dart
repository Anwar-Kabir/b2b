class Auction {
  final int id;
  final String uuid;
  final int shopId;
  final int inventoryId;
  final String auctionNumber;
  final String auctionDate;
  final String registrationLastDate;
  final String? approvedAt;
  final int? approvedBy;
  final String? rejectedAt;
  final int? rejectedBy;
  final String? rejectedReason;
  final int preDepositePercentage;
  final String highestBid;
  final String bidIncrement;
  final String? closeAt;
  final String createdAt;
  final String updatedAt;
  final Map<String, dynamic>? inventory;

  Auction({
    required this.id,
    required this.uuid,
    required this.shopId,
    required this.inventoryId,
    required this.auctionNumber,
    required this.auctionDate,
    required this.registrationLastDate,
    this.approvedAt,
    this.approvedBy,
    this.rejectedAt,
    this.rejectedBy,
    this.rejectedReason,
    required this.preDepositePercentage,
    required this.highestBid,
    required this.bidIncrement,
    this.closeAt,
    required this.createdAt,
    required this.updatedAt,
    this.inventory,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      id: json['id'],
      uuid: json['uuid'],
      shopId: json['shop_id'],
      inventoryId: json['inventory_id'],
      auctionNumber: json['auction_number'],
      auctionDate: json['auction_date'],
      registrationLastDate: json['registration_last_date'],
      approvedAt: json['approved_at'],
      approvedBy: json['approved_by'],
      rejectedAt: json['rejected_at'],
      rejectedBy: json['rejected_by'],
      rejectedReason: json['rejected_reason'],
      preDepositePercentage: json['pre_deposite_percentage'],
      highestBid: json['highest_bid'],
      bidIncrement: json['bid_increment'],
      closeAt: json['close_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      inventory: json['inventory'],
    );
  }
}
