import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/login_role_screen.dart';
import 'screens/registration_mixed_screen.dart';

void main() => runApp(MedicalAppointmentApp());

class MedicalAppointmentApp extends StatelessWidget {
  const MedicalAppointmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Appointment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2E86AB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E86AB),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E86AB),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E86AB),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2E86AB), width: 2),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/appointment': (context) => const AppointmentScreen(),
        '/login': (context) => const LoginRoleScreen(),
        '/registration': (context) => const RegistrationMixedScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
