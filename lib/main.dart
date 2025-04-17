import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart' as legacy_provider;
import 'package:provider/provider.dart';
import 'package:smart_retiree/providers/chat_provider.dart';
import 'package:smart_retiree/ui/initial/splash_screen.dart';
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
    return MultiProvider(
      providers: [
        legacy_provider.ChangeNotifierProvider(
            create: (context) => ChatProvider()),
      ],
      child: GlobalLoaderOverlay(
        overlayWidgetBuilder: (_) {
          return Loader.indicator();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Retiree',
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          navigatorKey: rootNavigatorKey,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: const SplashScreen(),
        ),
      ),
    );
    // GlobalLoaderOverlay(
    //   overlayWidgetBuilder: (_) {
    //     return Loader.indicator();
    //   },
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Smart Retiree',
    //     scaffoldMessengerKey: rootScaffoldMessengerKey,
    //     navigatorKey: rootNavigatorKey,
    //     theme: lightTheme,
    //     darkTheme: darkTheme,
    //     themeMode: ThemeMode.light,
    //     home: const SplashScreen(),
    //   ),
    // );
  }
}
