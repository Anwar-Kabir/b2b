class ProductDetails {
  final int? id;
  final int? manufacturerId;
  final int? categoryId;
  final int? uomId;
  final String? name;
  final String? slug;
  final String? modelNumber;
  final String? mpn;
  final String? hsCode;
  final String? description;
  final int? minOrderQuantity;
  final bool? active;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? code;
  final String? combinedCode;
  final List<Inventory>? inventories;

  ProductDetails({
    this.id,
    this.manufacturerId,
    this.categoryId,
    this.uomId,
    this.name,
    this.slug,
    this.modelNumber,
    this.mpn,
    this.hsCode,
    this.description,
    this.minOrderQuantity,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.combinedCode,
    this.inventories,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] as int?,
      manufacturerId: json['manufacturer_id'] as int?,
      categoryId: json['category_id'] as int?,
      uomId: json['uom_id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      modelNumber: json['model_number'] as String?,
      mpn: json['mpn'] as String?,
      hsCode: json['hs_code'] as String?,
      description: json['description'] as String?,
      minOrderQuantity: json['min_order_quantity'] as int?,
      active: json['active'] as bool?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      code: json['code'] as String?,
      combinedCode: json['combined_code'] as String?,
      inventories: (json['inventories'] as List<dynamic>?)
          ?.map((item) => Inventory.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manufacturer_id': manufacturerId,
      'category_id': categoryId,
      'uom_id': uomId,
      'name': name,
      'slug': slug,
      'model_number': modelNumber,
      'mpn': mpn,
      'hs_code': hsCode,
      'description': description,
      'min_order_quantity': minOrderQuantity,
      'active': active,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'code': code,
      'combined_code': combinedCode,
      'inventories': inventories?.map((item) => item.toJson()).toList(),
    };
  }
}

class Inventory {
  final int? id;
  final int? shopId;
  final int? taxId;
  final String? sku;
  final String? slug;
  final int? productId;
  final String? description;
  final String? keyFeatures;
  final int? stockQuantity;
  final int? packingQty;
  final String? purchasePrice;
  final String? salePrice;
  final String? offerPrice;
  final String? offerStart;
  final String? offerEnd;
  final String? shippingWeight;
  final bool? freeShipping;
  final String? availableFrom;
  final String? metaTitle;
  final String? metaDescription;
  final bool? active;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? isAuction;
  final int? bstiCertification;
  final Shop? shop;

  Inventory({
    this.id,
    this.shopId,
    this.taxId,
    this.sku,
    this.slug,
    this.productId,
    this.description,
    this.keyFeatures,
    this.stockQuantity,
    this.packingQty,
    this.purchasePrice,
    this.salePrice,
    this.offerPrice,
    this.offerStart,
    this.offerEnd,
    this.shippingWeight,
    this.freeShipping,
    this.availableFrom,
    this.metaTitle,
    this.metaDescription,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isAuction,
    this.bstiCertification,
    this.shop,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'] as int?,
      shopId: json['shop_id'] as int?,
      taxId: json['tax_id'] as int?,
      sku: json['sku'] as String?,
      slug: json['slug'] as String?,
      productId: json['product_id'] as int?,
      description: json['description'] as String?,
      keyFeatures: json['key_features'] as String?,
      stockQuantity: json['stock_quantity'] as int?,
      packingQty: json['packing_qty'] as int?,
      purchasePrice: json['purchase_price'] as String?,
      salePrice: json['sale_price'] as String?,
      offerPrice: json['offer_price'] as String?,
      offerStart: json['offer_start'] as String?,
      offerEnd: json['offer_end'] as String?,
      shippingWeight: json['shipping_weight'] as String?,
      freeShipping: json['free_shipping'] as bool?,
      availableFrom: json['available_from'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaDescription: json['meta_description'] as String?,
      active: json['active'] as bool?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isAuction: json['is_auction'] as int?,
      bstiCertification: json['bsti_certification'] as int?,
      shop: json['shop'] != null
          ? Shop.fromJson(json['shop'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'tax_id': taxId,
      'sku': sku,
      'slug': slug,
      'product_id': productId,
      'description': description,
      'key_features': keyFeatures,
      'stock_quantity': stockQuantity,
      'packing_qty': packingQty,
      'purchase_price': purchasePrice,
      'sale_price': salePrice,
      'offer_price': offerPrice,
      'offer_start': offerStart,
      'offer_end': offerEnd,
      'shipping_weight': shippingWeight,
      'free_shipping': freeShipping,
      'available_from': availableFrom,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'active': active,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_auction': isAuction,
      'bsti_certification': bstiCertification,
      'shop': shop?.toJson(),
    };
  }
}

class Shop {
  final int? id;
  final int? ownerId;
  final String? name;
  final String? legalName;
  final String? slug;
  final String? email;
  final String? tradeLicenseNo;
  final String? description;
  final String? policy;
  final String? externalUrl;
  final bool? active;
  final String? currentSaleAmount;
  final bool? phoneVerified;
  final bool? addressVerified;
  final String? approvedAt;
  final int? approvedBy;
  final String? rejectedAt;
  final int? rejectedBy;
  final String? rejectedReason;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  Shop({
    this.id,
    this.ownerId,
    this.name,
    this.legalName,
    this.slug,
    this.email,
    this.tradeLicenseNo,
    this.description,
    this.policy,
    this.externalUrl,
    this.active,
    this.currentSaleAmount,
    this.phoneVerified,
    this.addressVerified,
    this.approvedAt,
    this.approvedBy,
    this.rejectedAt,
    this.rejectedBy,
    this.rejectedReason,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as int?,
      ownerId: json['owner_id'] as int?,
      name: json['name'] as String?,
      legalName: json['legal_name'] as String?,
      slug: json['slug'] as String?,
      email: json['email'] as String?,
      tradeLicenseNo: json['trade_license_no'] as String?,
      description: json['description'] as String?,
      policy: json['policy'] as String?,
      externalUrl: json['external_url'] as String?,
      active: json['active'] as bool?,
      currentSaleAmount: json['current_sale_amount'] as String?,
      phoneVerified: json['phone_verified'] as bool?,
      addressVerified: json['address_verified'] as bool?,
      approvedAt: json['approved_at'] as String?,
      approvedBy: json['approved_by'] as int?,
      rejectedAt: json['rejected_at'] as String?,
      rejectedBy: json['rejected_by'] as int?,
      rejectedReason: json['rejected_reason'] as String?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'legal_name': legalName,
      'slug': slug,
      'email': email,
      'trade_license_no': tradeLicenseNo,
      'description': description,
      'policy': policy,
      'external_url': externalUrl,
      'active': active,
      'current_sale_amount': currentSaleAmount,
      'phone_verified': phoneVerified,
      'address_verified': addressVerified,
      'approved_at': approvedAt,
      'approved_by': approvedBy,
      'rejected_at': rejectedAt,
      'rejected_by': rejectedBy,
      'rejected_reason': rejectedReason,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
