import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/forgetpassword/change_password.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';
import 'package:isotopeit_b2b/view/signup/signup.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  // Initialize the controller
  final LoginController _loginController = LoginController();

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          title: const Text(
            'Forget Password',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _loginController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 70),

          

              Image.asset(
                AppImages.splashLogo,
                height: 80,
                width: MediaQuery.of(context).size.width - 50,
              ),

              
                  const SizedBox(height: 70),

              const Row(
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              // Custom Text Field for Email
              CustomTextField(
                prefixIcon: Icons.email,
                 hintText: 'anwar@gmail.com',
                controller: _loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _loginController.validateEmail,
                onChanged: (_) {
                  //_loginController.formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 20),

              Center(
                child: Text.rich(
                  TextSpan(
                    text: " ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: 'We Will Send verification to your Email',
                          style: const TextStyle(
                            color: Color(0xFF7F56D9),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //Get.to(Signup());
                            }),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    //_loginController.login();
                    Get.to(const ChangePassword(), transition: Transition.rightToLeftWithFade);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7F56D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
