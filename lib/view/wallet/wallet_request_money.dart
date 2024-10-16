import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class BalanceRequest extends StatefulWidget {
  const BalanceRequest({super.key});

  @override
  State<BalanceRequest> createState() => _BalanceRequestState();
}

class _BalanceRequestState extends State<BalanceRequest> {

   final SignupController _controller = Get.put(SignupController());
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw Request',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available balance text
            Center(
              child: RichText(
                text: const TextSpan(
                  text: 'Your Available Balance is ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: '৳ 9001.00',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
      
           
            const SizedBox(height: 10),
      
             
            

            const LabelWithAsterisk(labelText: "Request Money", isRequired: true,),
            CustomTextField(
              prefixIcon: Icons.monetization_on,
              hintText: '500',
              controller: _controller.nameController,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateName,
              onChanged: (value) {
               // _controller.onFieldChanged();
              },
            ),
            const SizedBox(height: 20),
      
            // Request Button
            

            Spacer(),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add Save functionality
                },
                icon: const Icon(Icons.send),
                label: const Text("Request"),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(double.infinity, 50), // Make button full-width
                  backgroundColor: AppColor
                      .primaryColor, // Change this to your desired color
                  // For text color:
                  foregroundColor: Colors.white, // Text and icon color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
