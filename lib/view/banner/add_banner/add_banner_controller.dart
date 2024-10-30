import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/BottomNav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBannerController extends GetxController {
 

  //app validation from
  final appValidator = AppValidation();

  final appEmailValidator = TextEditingController();
  final appPasswordValidator = TextEditingController();

 
   
}
