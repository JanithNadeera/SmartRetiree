import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/custom_appbar.dart';
import 'package:smart_retiree/shared_widgets/input_form_field.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/mp/profile/widgets/profile_image.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/validators.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();

  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    final user = ref.read(userProvider)!;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _occupationController.text = user.occupation;
  }

  Future<void> _updateProfile(AppUser user) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final updatedUser = user.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        occupation: _occupationController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(updatedUser.toMap());

      ref.read(userProvider.notifier).state = updatedUser;

      CoreUtils.showToast(type: ToastType.success, message: 'Profile updated');
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Error updating profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ProfileImage(url: user.profilePhoto, onTap: () {}),
              const SizedBox(height: 32),
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
                readOnly: true,
              ),
              const Gap(16),
              InputField(
                hintText: "Occupation",
                prefixIcon: Icons.work_outline_outlined,
                controller: _occupationController,
                textInputType: TextInputType.text,
              ),
              const Gap(16),
              SubmitButton(
                onPressed: () => _updateProfile(user),
                label: "SAVE",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
