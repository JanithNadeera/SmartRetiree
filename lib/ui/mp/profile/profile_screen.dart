import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/shared_widgets/logout_popup.dart';
import 'package:smart_retiree/ui/mp/profile/edit_profile.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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

  _listTile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      leading: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    /// Profile Picture
                    Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage(profileImagePath ??
                                    'assets/images/Avatar.png'),
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
                        const Gap(16),
                        Text(
                          '${_firstNameController.text} ${_lastNameController.text}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        Text(
                          _emailController.text,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Gap(32),
                    _listTile("First Name", _firstNameController.text,
                        Icons.text_fields_sharp),
                    const Gap(16),

                    _listTile("Last Name", _lastNameController.text,
                        Icons.text_fields_sharp),
                    const Gap(16),

                    _listTile("Email", _emailController.text, Icons.email),
                    const Gap(16),

                    _listTile(
                        "Occuption", _occupationController.text, Icons.work),
                    const Gap(16),

                    GestureDetector(
                      onTap: () {
                        CoreUtils.heroDialog(const LogoutPopup());
                      },
                      child: ListTile(
                        title: Text(
                          "LogOut",
                          style: TextStyle(
                              color: context.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: context.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
