import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hazard_provider.dart';
import '../providers/inspection_provider.dart';
import '../utils/app_theme.dart';
import 'incident_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hazardProvider = Provider.of<HazardProvider>(context);
    final inspectionProvider = Provider.of<InspectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.shield_rounded, color: AppTheme.accentOrange),
            ),
            const SizedBox(width: 12),
            const Text('SafeX Guardian'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: hazardProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.accentOrange))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Facility Safety Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textLight),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Open Hazards',
                    hazardProvider.openCount.toString(),
                    Icons.error_outline_rounded,
                    AppTheme.dangerRed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard(
                    'In Progress',
                    hazardProvider.inProgressCount.toString(),
                    Icons.pending_actions_rounded,
                    AppTheme.warningYellow,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Resolved',
                    hazardProvider.resolvedCount.toString(),
                    Icons.check_circle_outline_rounded,
                    AppTheme.successGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard(
                    'Compliance',
                    '${inspectionProvider.compliancePercentage.toStringAsFixed(0)}%',
                    Icons.verified_user_outlined,
                    AppTheme.accentOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Safety Incidents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textLight),
            ),
            const SizedBox(height: 12),
            hazardProvider.hazards.isEmpty
                ? const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No incidents logged yet.'),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hazardProvider.hazards.take(3).length,
              itemBuilder: (context, index) {
                final item = hazardProvider.hazards[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.cardBg,
                      child: Icon(
                        Icons.warning_rounded,
                        color: item.severity.index >= 2 ? AppTheme.dangerRed : AppTheme.warningYellow,
                      ),
                    ),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item.category} • ${item.location}'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncidentDetailScreen(hazardId: item.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textLight),
          ),
        ],
      ),
    );
  }
}