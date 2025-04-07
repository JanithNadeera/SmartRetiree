import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:smart_retiree/ui/initial/onboard_screen.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/firebase_options.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) {
        return Loader.indicator();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onboarding Screen',
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        navigatorKey: rootNavigatorKey,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: const OnbordingScreen(),
      ),
    );
  }
}
