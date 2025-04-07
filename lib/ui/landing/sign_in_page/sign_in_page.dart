import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:smart_retiree/shared_widgets/input_form_field.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/widgets/auth_footer.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const path = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Spacer(),
                    Transform.rotate(
                      angle: -15 * 3.141592653589793 / 180,
                      child: Text(
                        'RC',
                        style: TextStyle(
                          fontFamily: "Agbalumo",
                          color: Color(0xFFEC2824),
                          fontSize: 120,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: context.onSurface,
                              offset: Offset(1.5, 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    InputField(
                      controller: _emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      validator: (email) {
                        if (email == null || email.trim().isEmpty) {
                          return "Provide an email address";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email)) {
                          return "Please use a valid email address";
                        }
                        return null;
                      },
                    ),
                    Gap(16),
                    InputField(
                      controller: _passwordController,
                      hintText: "Password",
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: Icons.key,
                      obscureText: true,
                      validator: (password) {
                        if (password == null || password.trim().isEmpty) {
                          return "Provide a password";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 24),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot password?',
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SubmitButton(
                      onPressed: () async {},
                      label: "Sign In",
                    ),
                    // SocialSignIn(),
                    AuthFooter(isLogin: true),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
