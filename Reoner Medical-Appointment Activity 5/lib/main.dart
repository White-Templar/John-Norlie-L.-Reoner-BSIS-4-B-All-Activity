import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/login_role_screen.dart';
import 'screens/registration_mixed_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/navigation_demo_screen.dart';
import 'screens/shopping_cart_screen.dart';
import 'screens/todo_list_screen.dart';
import 'screens/media_gallery_screen.dart';
import 'screens/theme_demo_screen.dart';
import 'screens/profile_card_screen.dart';
import 'screens/features_demo_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/todo_provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => TodoProvider()),
    ],
    child: const MedicalAppointmentApp(),
  ),
);

class MedicalAppointmentApp extends StatelessWidget {
  const MedicalAppointmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Medical Appointment App',
          theme: themeProvider.currentTheme,
      initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/appointment': (context) => const AppointmentScreen(),
            '/login': (context) => const LoginRoleScreen(),
            '/registration': (context) => const RegistrationMixedScreen(),
            '/about': (context) => const AboutScreen(),
            '/contact': (context) => const ContactScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/navigation_demo': (context) => const NavigationDemoScreen(),
            '/shopping_cart': (context) => const ShoppingCartScreen(),
            '/todo_list': (context) => const TodoListScreen(),
            '/media_gallery': (context) => const MediaGalleryScreen(),
            '/theme_demo': (context) => const ThemeDemoScreen(),
            '/profile_card': (context) => const ProfileCardScreen(),
            '/features_demo': (context) => const FeaturesDemoScreen(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
