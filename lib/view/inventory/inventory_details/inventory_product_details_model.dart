// inventory_detail_model.dart

class InventoryDetailModel {
  final int id;
  final int productId;
  final String productName;
  final String sku;
  final bool active;
  final double salePrice;
  final int stockQuantity;
  final String? description;
  final List<Attribute> attributes;
  final List<ImageData> images;
  final String? purchaseprice;
  final int? packing_qty;
  final String? availabledateTime;

  InventoryDetailModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.sku,
    required this.active,
    required this.salePrice,
    required this.stockQuantity,
    this.description,
    required this.attributes,
    required this.images,
    this.purchaseprice,
    this.packing_qty,
    this.availabledateTime,
  });

  factory InventoryDetailModel.fromJson(Map<String, dynamic> json) {
    return InventoryDetailModel(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      sku: json['sku'],
      active: json['active'],
      salePrice: double.parse(json['sale_price']),
      stockQuantity: json['stock_quantity'],
      purchaseprice: json['purchase_price'],
      packing_qty: json['packing_qty'],
      availabledateTime: json['available_from'],
      

      
      description: json['description'],
      attributes: (json['attributes'] as List)
          .map((attr) => Attribute.fromJson(attr))
          .toList(),
      images: (json['images'] as List)
          .map((img) => ImageData.fromJson(img))
          .toList(),
    );
  }
}

class Attribute {
  final int id;
  final String name;
  final List<AttributeValue> values;

  Attribute({required this.id, required this.name, required this.values});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      values: (json['values'] as List)
          .map((val) => AttributeValue.fromJson(val))
          .toList(),
    );
  }
}

class AttributeValue {
  final int id;
  final String value;
  final String color;

  AttributeValue({required this.id, required this.value, required this.color});

  factory AttributeValue.fromJson(Map<String, dynamic> json) {
    return AttributeValue(
      id: json['id'],
      value: json['value'],
      color: json['color'],
    );
  }
}

class ImageData {
  final int id;
  final String url;

  ImageData({required this.id, required this.url});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      url: json['url'],
    );
  }
}



//delete model

class InventoryDeleteResponse {
  final String message;

  InventoryDeleteResponse({required this.message});

  factory InventoryDeleteResponse.fromJson(Map<String, dynamic> json) {
    return InventoryDeleteResponse(
      message: json['message'] ?? '',
    );
  }
}
