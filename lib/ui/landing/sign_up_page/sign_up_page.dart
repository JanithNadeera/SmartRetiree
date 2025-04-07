import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/shared_widgets/input_form_field.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/sign_in_page.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/widgets/auth_footer.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/user_role_selector.dart';
import 'package:smart_retiree/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late UserRole userRole;

  @override
  void initState() {
    userRole = UserRole.retiree;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _occupationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                    UserRoleSelector(
                      selected: userRole,
                      onSelect: (type) {
                        userRole = type;
                        setState(() {});
                      },
                    ),
                    const Gap(16),
                    InputField(
                      hintText: "First Name",
                      prefixIcon: Icons.person_outline_outlined,
                      controller: _firstNameController,
                      textInputType: TextInputType.name,
                      validator: Validators.validateName,
                    ),
                    const Gap(16),
                    InputField(
                      hintText: "Last Name",
                      prefixIcon: Icons.person_outline_outlined,
                      controller: _lastNameController,
                      textInputType: TextInputType.name,
                      validator: Validators.validateName,
                    ),
                    const Gap(16),
                    InputField(
                      hintText: "Email",
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    const Gap(16),
                    InputField(
                      hintText: "Occupation",
                      prefixIcon: Icons.work_outline,
                      controller: _occupationController,
                      textInputType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                      ],
                      validator: Validators.validateOccupation,
                    ),
                    const Gap(16),
                    InputField(
                      hintText: "Password",
                      prefixIcon: Icons.key,
                      controller: _passwordController,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: Validators.validatePassword,
                    ),
                    const Gap(16),
                    InputField(
                      hintText: "Confirm Password",
                      prefixIcon: Icons.key,
                      controller: _confirmPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) => Validators.validateConfrimPassword(
                        _passwordController.text,
                        value,
                      ),
                    ),
                    const Gap(16),
                    SubmitButton(
                      onPressed: _signUp,
                      label: "Sign Up",
                    ),
                    const Gap(16),
                    const AuthFooter(isLogin: false),
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

  void _signUp() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (_formKey.currentState!.validate()) {
      try {
        Loader.show(true);

        final UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final user = userCredential.user;

        if (user != null) {
          await firestore.collection('users').doc(user.uid).set({
            'first_name': _firstNameController.text.trim(),
            'last_name': _lastNameController.text.trim(),
            'email': user.email,
            'occupation': _occupationController.text.trim(),
            'user_role': userRole.name,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        CoreUtils.showToast(
          type: ToastType.success,
          message: "User registered successfully",
        );

        CoreUtils.postFrameCall(() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen())));
      } on FirebaseAuthException catch (e) {
        CoreUtils.showToast(
          type: ToastType.error,
          message: e.message ?? "Authentication failed",
        );
      } catch (e) {
        CoreUtils.showToast(
          type: ToastType.error,
          message: "Error: $e",
        );
      } finally {
        Loader.show(false);
      }
    }
  }
}
