import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/order/orderlist/model_order_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderController extends GetxController {
  var isLoading = true.obs;
  var orderList = <Order>[].obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {

     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that we retrieve a non-null token
    final token = prefs.getString('token') ?? ''; 

    
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(AppURL.orderList),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var orders = data['data']['data'] as List;

        orderList.value = orders.map((order) => Order.fromJson(order)).toList();
      } else {
        Get.snackbar("Error", "Failed to load orders");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }
}
