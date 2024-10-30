class SupplierRegistrationModel {
  final String shopName;
  final String shopEmail;
  final String slug;
  final String tradeLicenseNo;
  final String nid;
  final String merchantName;
  final String merchantPhone;
  final String merchantEmail;
  final String division;
  final String district;
  final String upazila;
  final String addressLine1;
  final String postalCode;
  final String password;
  final String passwordConfirmation;
  final String cityCorporationPourashova;
  final String sameAddress;

  SupplierRegistrationModel({
    required this.shopName,
    required this.shopEmail,
    required this.slug,
    required this.tradeLicenseNo,
    required this.nid,
    required this.merchantName,
    required this.merchantPhone,
    required this.merchantEmail,
    required this.division,
    required this.district,
    required this.upazila,
    required this.addressLine1,
    required this.postalCode,
    required this.password,
    required this.passwordConfirmation,
    required this.cityCorporationPourashova,
    required this.sameAddress,
  });

  // Converts SupplierRegistrationModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'shop_name': shopName,
      'shop_email': shopEmail,
      'slug': slug,
      'trade_license_no': tradeLicenseNo,
      'nid': nid,
      'merchant_name': merchantName,
      'merchant_phone': merchantPhone,
      'merchant_email': merchantEmail,
      'division': division,
      'district': district,
      'upazila': upazila,
      'address_line1': addressLine1,
      'postal_code': postalCode,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'city_corporation_pourashova': cityCorporationPourashova,
      'same_address': sameAddress,
    };
  }

  // Creates a SupplierRegistrationModel instance from a JSON map
  factory SupplierRegistrationModel.fromJson(Map<String, dynamic> json) {
    return SupplierRegistrationModel(
      shopName: json['shop_name'],
      shopEmail: json['shop_email'],
      slug: json['slug'],
      tradeLicenseNo: json['trade_license_no'],
      nid: json['nid'],
      merchantName: json['merchant_name'],
      merchantPhone: json['merchant_phone'],
      merchantEmail: json['merchant_email'],
      division: json['division'],
      district: json['district'],
      upazila: json['upazila'],
      addressLine1: json['address_line1'],
      postalCode: json['postal_code'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      cityCorporationPourashova: json['city_corporation_pourashova'],
      sameAddress: json['same_address'],
    );
  }
}
