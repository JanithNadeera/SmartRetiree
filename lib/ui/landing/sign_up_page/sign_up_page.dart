import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/shared_widgets/input_form_field.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/widgets/auth_footer.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const path = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _assignreward = ValueNotifier(true);
  // late CustomerType customerType;

  String? appleToken;

  @override
  void initState() {
    // customerType = CustomerTypeUtils.getCustomerTypeById(3);
    super.initState();
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _hotelNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
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
              child: Column(
                children: [
                  const Spacer(),
                  // CustomerTypeSelector(
                  //   selectedId: customerType.id,
                  //   onSelect: (type) {
                  //     customerType = type;
                  //     setState(() {});
                  //   },
                  // ),
                  Gap(16),

                  InputField(
                    hintText: "Business Name",
                    prefixIcon: Icons.handshake_outlined,
                    controller: _businessNameController,
                    textInputType: TextInputType.name,
                  ),
                  Gap(16),

                  InputField(
                    hintText: "Hotel Name",
                    prefixIcon: Icons.hotel_outlined,
                    controller: _hotelNameController,
                    textInputType: TextInputType.name,
                  ),
                  Gap(16),

                  InputField(
                    hintText: "First Name",
                    prefixIcon: Icons.person_outline_outlined,
                    controller: _firstNameController,
                    textInputType: TextInputType.name,
                  ),
                  Gap(16),
                  InputField(
                    hintText: "Last Name",
                    prefixIcon: Icons.person_outline_outlined,
                    controller: _lastNameController,
                    textInputType: TextInputType.name,
                  ),
                  Gap(16),

                  InputField(
                    hintText: "Email",
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  Gap(16),
                  InputField(
                    hintText: "Phone",
                    prefixIcon: Icons.phone,
                    controller: _phoneNumberController,
                    textInputType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(21),
                      // PhoneNumberFormatter()
                    ],
                  ),
                  Gap(16),
                  InputField(
                    hintText: "Password",
                    prefixIcon: Icons.key,
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  Gap(16),
                  InputField(
                    hintText: "Confirm Password",
                    prefixIcon: Icons.key,
                    controller: _confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  Gap(16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _assignreward,
                          builder: (context, value, child) => Checkbox(
                            value: _assignreward.value,
                            onChanged: (bool? value) {
                              _assignreward.value = value!;
                            },
                            activeColor: context.primary,
                          ),
                        ),
                        Text(
                          "Join as a reward member",
                          style: context.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                  SubmitButton(
                    onPressed: () async {},
                    label: "Sign Up",
                  ),
                  AuthFooter(isLogin: false),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
