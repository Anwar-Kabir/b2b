import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
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
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
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
                    "New Password",
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
                prefixIcon: Icons.password,
                hintText: '#33anwar',
                controller: _loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                //validator: _loginController.validateEmail,
                onChanged: (_) {
                  //_loginController.formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 20),

              const Row(
                children: [
                  Text(
                    "Conform Password",
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
                prefixIcon: Icons.password,
                hintText: '#33anwar',
                controller: _loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                //validator: _loginController.validateEmail,
                onChanged: (_) {
                  //_loginController.formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 20),

              const Spacer(),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _loginController.login();
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
