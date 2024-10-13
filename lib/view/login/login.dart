import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/utils/string.dart';
import 'package:isotopeit_b2b/view/forgetpassword/forget_password.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';
import 'package:isotopeit_b2b/view/signup/signup.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
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
     // appBar: AppBar(title: const Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _loginController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
              const SizedBox(height: 150),

              Image.asset(
                AppImages.splashLogo,
                height: 80,
                width: MediaQuery.of(context).size.width - 50,
              ),

              const SizedBox(height: 80),

          
               const Row(
                children: [
                  Text(
                    AppStrings.loginEmail,
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
          
                const Row(
                children: [
                  Text(
                    AppStrings.loginPassword,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
          
              // Custom Text Field for Password
              CustomTextField(
                prefixIcon: Icons.lock,
                hintText: '**Ban71',
                controller: _loginController.passwordController,
                isObscure: _loginController.obscurePassword,
                onChanged: (_) {
                  //_loginController.formKey.currentState?.validate();
                },
                suffixIcon: _loginController.obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                onSuffixTap: () {
                  setState(() {
                    _loginController.togglePasswordVisibility();
                  });
                },
                validator: _loginController.validatePassword,
              ),
              const SizedBox(height: 30),
          
              // Login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:(){
                    _loginController.login();
                     
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF7F56D9),  
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
          
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Forget Password? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: 'Click here',
                          style: const TextStyle(
                            color: Color(0xFF7F56D9),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(const ForgetPassword());
                            }),
                    ],
                  ),
                ),
              ),
          
              const SizedBox(height: 20,),
          
              // Don't have an account
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don’t have an account yet? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: Color(0xFF7F56D9),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(Signup());
                            }),
                    ],
                  ),
                ),
              ),
          
              const Spacer(),
          
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Version",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: ' v.0.1',
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
          
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
