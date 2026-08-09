import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/hazard_provider.dart';
import 'providers/inspection_provider.dart';
import 'screens/main_navigation_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SafeXApp());
}

class SafeXApp extends StatelessWidget {
  const SafeXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HazardProvider()),
        ChangeNotifierProvider(create: (_) => InspectionProvider()),
      ],
      child: MaterialApp(
        title: 'SafeX Guardian',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}