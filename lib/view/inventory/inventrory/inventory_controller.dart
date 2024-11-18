import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/inventory/inventrory/inventory_model.dart'; // Adjust the path to your InventoryActiveModel

class InventoryActiveController extends GetxController {
  // Observable lists for different product categories
  var activeProducts = <InventoryActiveModel>[].obs;
  var inactiveProducts = <InventoryActiveModel>[].obs;
  var inStockProducts = <InventoryActiveModel>[].obs;
  var outOfStockProducts = <InventoryActiveModel>[].obs;

  var isLoading = true.obs; // Loading state
  var hasError = false.obs; // Error state

  final TokenService _tokenService = TokenService();

  @override
  void onInit() {
    super.onInit();
    fetchActiveProducts();
    fetchInactiveProducts();
    fetchInStockProducts();
    fetchOutOfStockProducts();
  }

  Future<void> fetchActiveProducts() async {
    await _fetchProducts(
      // url: 'https://e-commerce.isotopeit.com/api/inventories/active',
       url: '${AppURL.baseURL}api/inventories/active',

      productList: activeProducts,
    );
  }

  Future<void> fetchInactiveProducts() async {
    await _fetchProducts(
      //url: 'https://e-commerce.isotopeit.com/api/inventories/inactive',
      url: '${AppURL.baseURL}api/inventories/inactive',
      productList: inactiveProducts,
    );
  }

  Future<void> fetchInStockProducts() async {
    await _fetchProducts(
      // url: 'https://e-commerce.isotopeit.com/api/inventories/inStock',
      url: '${AppURL.baseURL}api/inventories/inStock',
      productList: inStockProducts,
    );
  }

  Future<void> fetchOutOfStockProducts() async {
    await _fetchProducts(
      // url: 'https://e-commerce.isotopeit.com/api/inventories/outOfStock',
      url: '${AppURL.baseURL}api/inventories/outOfStock',
      productList: outOfStockProducts,
    );
  }

  Future<void> _fetchProducts({
    required String url,
    required RxList<InventoryActiveModel> productList,
  }) async {
    try {
      isLoading.value = true;
      hasError.value = false; // Reset error state before fetching

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${_tokenService.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print(
          "Fetching products from $url, status code: ${response.statusCode}"); // Log status code

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> fetchedList = data['data'] ?? [];

        print("Fetched data from $url: $fetchedList"); // Log the fetched data

        // Update product list and handle empty data case
        productList.value = fetchedList
            .map((json) => InventoryActiveModel.fromJson(json))
            .toList();

        print(
            "Updated Product List (${productList.length}): ${productList.map((product) => product.salePrice).toList()}"); // Print sale prices

        // If no products are found, set hasError to true
        if (productList.isEmpty) {
          print("No products found for URL: $url");
          hasError.value = true;
        }
      } else {
        print(
            "Failed to load products, status code: ${response.statusCode}"); // Log the status code
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error fetching products from $url: $e");
      hasError.value = true; // Set error state if an exception occurs
    } finally {
      isLoading.value = false;
    }
  }
}
