class SupplierRegistrationModel {
  final String shopName;
  final String merchantName;
  final String merchantPhone;
  final String address;
  final String interestedArea;
 
  final String division;
  final String district;
  final String upazila;
   
  final String postalCode;
  final String password;
  final String passwordConfirmation;
   

  SupplierRegistrationModel({
    required this.shopName,
    required this.merchantName,
    required this.merchantPhone,
    required this.address,
    required this.interestedArea,
    
    required this.division,
    required this.district,
    required this.upazila,
     
    required this.postalCode,
    required this.password,
    required this.passwordConfirmation,
    
  });

  // Converts SupplierRegistrationModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'shop_name': shopName,
      'merchant_name': merchantName,
      'merchant_phone': merchantPhone,
      'address_line1': address,
      'interested_area': interestedArea,
       
      'division': division,
      'district': district,
      'upazila': upazila,
      'postal_code': postalCode,
      'password': password,
      'password_confirmation': passwordConfirmation,
      
    };
  }

  // Creates a SupplierRegistrationModel instance from a JSON map
  factory SupplierRegistrationModel.fromJson(Map<String, dynamic> json) {
    return SupplierRegistrationModel(
      shopName: json['shop_name'],
      merchantName: json['merchant_name'],
      merchantPhone: json['merchant_phone'],
      address: json['address_line1'],
      interestedArea: json['interested_area'],
      division: json['division'],
      district: json['district'],
      upazila: json['upazila'],
      postalCode: json['postal_code'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }
}
