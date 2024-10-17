import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/forgetpassword/forget_password.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';
import 'package:isotopeit_b2b/view/signup/signup.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints
                    .maxHeight, // Ensure the form takes at least full height
              ),
              child: IntrinsicHeight(
                // Wraps to the content height but expands if needed
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Adjust for keyboard
                  ),
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
                        // Email field
                        CustomTextField(
                          prefixIcon: Icons.email,
                          hintText: 'anwar@gmail.com',
                          controller: _loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: _loginController.validateEmail,
                        ),
                        const SizedBox(height: 20),
                        // Password field
                        CustomTextField(
                          prefixIcon: Icons.lock,
                          hintText: '**Ban71',
                          maxLines: 1,
                          controller: _loginController.passwordController,
                          isObscure: _loginController.obscurePassword,
                          suffixIcon: _loginController.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onSuffixTap:
                              _loginController.togglePasswordVisibility,
                          validator: _loginController.validatePassword,
                        ),
                        const SizedBox(height: 30),
                        // Login button with Circular Avatar
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _loginController.login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: _loginController.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
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
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(
                                          const ForgetPassword(),
                                          transition:
                                              Transition.rightToLeftWithFade,
                                        );
                                      }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(
                                          Signup(),
                                          transition:
                                              Transition.rightToLeftWithFade,
                                        );
                                      }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                        // Additional action
                                      }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
