import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';

import 'package:smart_retiree/shared_widgets/input_form_field.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/widgets/auth_footer.dart';
import 'package:smart_retiree/ui/mp/navigation/navigation_screen.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        Loader.show(true);
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final uid = userCredential.user?.uid;
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (doc.exists && context.mounted) {
          final appUser = AppUser.fromMap(uid!, doc.data()!);
          ref.read(userProvider.notifier).state = appUser;
        }

        CoreUtils.postFrameCall(() => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const NavigationScreen()),
            (route) => false));
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password.';
            break;
          default:
            errorMessage = 'Login failed. Please try again.';
        }

        CoreUtils.showToast(type: ToastType.error, message: errorMessage);
      } finally {
        Loader.show(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
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
                    InputField(
                      controller: _emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      validator: Validators.validateEmail,
                    ),
                    const Gap(16),
                    InputField(
                      controller: _passwordController,
                      hintText: "Password",
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: Icons.key,
                      obscureText: true,
                      validator: Validators.validatePassword,
                    ),
                    const Gap(32),
                    SubmitButton(
                      onPressed: _login,
                      label: "Sign In",
                    ),
                    const Gap(16),
                    const AuthFooter(isLogin: true),
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
