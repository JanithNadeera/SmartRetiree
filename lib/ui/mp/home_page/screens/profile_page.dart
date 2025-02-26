import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/widgets/profile_widget.dart';
import 'package:smart_retiree/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Log Out", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red.withOpacity(0.5),
                    width: 5.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * .3,
                child: Row(
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: Image.asset("assets/images/verified.png"),
                    ),
                  ],
                ),
              ),
              Text(
                'johndoe@gmail.com',
                style: TextStyle(
                  color: Constants.blackColor.withOpacity(.3),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: size.height * .7,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfileWidget(
                        icon: Icons.person, title: 'Edit Profile'),
                    const ProfileWidget(
                        icon: Icons.settings, title: 'Settings'),
                    const ProfileWidget(
                        icon: Icons.notifications, title: 'Notifications'),
                    const ProfileWidget(icon: Icons.chat, title: 'FAQs'),
                    const ProfileWidget(icon: Icons.share, title: 'Share'),
                    GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: const ProfileWidget(
                        icon: Icons.logout,
                        color: Color(0xFFff4242),
                        title: 'Log Out',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProfileWidget extends StatelessWidget {
//   final IconData icon;
//   final String title;

//   const ProfileWidget({required this.icon, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.green[900]),
//           const SizedBox(width: 20),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
