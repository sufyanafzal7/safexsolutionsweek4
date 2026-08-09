import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'hazard_list_screen.dart';
import 'audit_checklist_screen.dart';
import 'report_hazard_screen.dart';
import '../utils/app_theme.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    HazardListScreen(),
    AuditChecklistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.accentOrange,
        icon: const Icon(Icons.add_alert_rounded, color: Colors.white),
        label: const Text('Report Hazard', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportHazardScreen()),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.accentOrange,
        unselectedItemColor: AppTheme.textMuted,
        backgroundColor: AppTheme.cardBg,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            label: 'Hazards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_rounded),
            label: 'Site Audit',
          ),
        ],
      ),
    );
  }
}