import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  child: Form(
                    key: _loginController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 150),
                        Image.asset(
                          'assets/logos/logo.png',
                          width: 150.w,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.pykariTitle,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.pykariSubTitle,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          prefixIcon: Icons.email,
                          hintText: 'Enter Your Email',
                          controller: _loginController.appEmailValidator,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => _loginController.appValidator
                              .validateEmail(value),
                        ),
                        const SizedBox(height: 20),

                        // Password field with Obx for reactive updates
                        Obx(() {
                          return CustomTextField(
                            prefixIcon: Icons.lock,
                            hintText: 'Password',
                            maxLines: 1,
                            controller: _loginController.appPasswordValidator,
                            isObscure: _loginController.obscurePassword.value,
                            suffixIcon: _loginController.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onSuffixTap:
                                _loginController.togglePasswordVisibility,
                            validator: (value) => _loginController.appValidator
                                .validatePassword(value),
                          );
                        }),

                        const SizedBox(height: 30),

                        // Login button with loading spinner using Obx
                        Obx(() {
                          return SizedBox(
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
                              child: _loginController.isLoading.value
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
                          );
                        }),

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
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                        SignUpPage(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                      );
                                    },
                                ),
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
                                    ..onTap = () {},
                                ),
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
