import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.isLogin,
  });
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Don\'t have an account? ' : 'Already have an account? ',
          style: context.bodyMedium,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            isLogin ? 'Sign Up' : 'Sign In',
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
