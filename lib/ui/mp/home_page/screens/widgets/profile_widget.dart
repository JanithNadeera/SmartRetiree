import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/constants.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileWidget({
    super.key,
    required this.icon,
    required this.title,
    Color? color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Constants.blackColor.withOpacity(.4),
            size: 16,
          )
        ],
      ),
    );
  }
}
