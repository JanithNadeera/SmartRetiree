import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

enum UserRole {
  retiree,
  seeker,
}

class UserRoleSelector extends StatelessWidget {
  final ValueChanged<UserRole>? onSelect;
  final UserRole? selected;
  const UserRoleSelector({
    super.key,
    this.onSelect,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      enabled: onSelect != null,
      initialSelection: UserRole.retiree,
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        fillColor: context.secondaryContainer,
        filled: true,
      ),
      width: double.maxFinite,
      textStyle: context.bodyLarge,
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
      ),
      selectedTrailingIcon: const Icon(
        Icons.keyboard_arrow_up_rounded,
      ),
      menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
              (states) => context.primaryContainer),
          surfaceTintColor: WidgetStateProperty.resolveWith(
              (states) => context.primaryContainer)),
      onSelected: (type) {
        onSelect?.call(type!);
      },
      dropdownMenuEntries: <DropdownMenuEntry<UserRole>>[
        ...UserRole.values.map(
            (e) => DropdownMenuEntry(value: e, label: e.name.toUpperCase()))
      ],
    );
  }
}
