import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/shared_widgets/custom_appbar.dart';
import 'package:smart_retiree/shared_widgets/input_form_field.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
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

  bool isLoading = true;
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        final data = doc.data()!;
        _firstNameController.text = data['first_name'] ?? '';
        _lastNameController.text = data['last_name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _occupationController.text = data['occupation'] ?? '';
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: "Failed to load profile");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'occupation': _occupationController.text.trim(),
      });

      CoreUtils.showToast(type: ToastType.success, message: 'Profile updated');
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Error updating profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    /// Profile Picture
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: AssetImage(
                                profileImagePath ?? 'assets/images/Avatar.png'),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: InkWell(
                              onTap: () {}, // Optional: add image picker
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.edit,
                                    size: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      onPressed: _updateProfile,
                      label: "SAVE",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
