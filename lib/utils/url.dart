class AppURL {
  static const String baseURL = "https://e-commerce.isotopeit.com/";

  //autu
  static const String login = "${baseURL}api/suppliers-login"; //post

  //attribute
  static const String attributeList = "${baseURL}api/attribute"; //get
  static const String attributeCreate = "${baseURL}api/attribute"; //post
  static const String attributeShow = "${baseURL}api/attribute/1"; //get
  static const String attributeUpdate = "${baseURL}api/attribute/7"; //put
  static const String attributeValueCreate = "${baseURL}api/attribute-values"; //post
  static const String attributeValueUpdate ="${baseURL}api/attribute-values/22/"; //put

  //category
  static const String categoryGroupSelect =
      "${baseURL}api/select/category-groups"; //get
  static const String categoryList = "${baseURL}api/category"; //get

  //tag
  static const String tagList = "${baseURL}api/tag"; //get

  //Product
  static const String productList = "${baseURL}api/product/"; //get
  static const String productShow = "${baseURL}api/product/2/show"; //get;

  //Order
  static const String orderList = "${baseURL}api/order"; //get
  static const String orderShow = "${baseURL}api/order/8/show"; //get
  static const String orderApprove = "${baseURL}api/order/9/approve"; //post
 
  //banner
  static const String bannersList = "${baseURL}api/banners"; //get
  static const String bannerCreate = "${baseURL}api/banners"; //post
  static const String bannerUpdate = "${baseURL}api/banners/14"; //put
  static const String bannerDelete = "${baseURL}api/banners/14"; //delete
  
}
