import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/hazard_model.dart';
import '../providers/hazard_provider.dart';
import '../utils/app_theme.dart';

class IncidentDetailScreen extends StatelessWidget {
  final String hazardId;

  const IncidentDetailScreen({super.key, required this.hazardId});

  @override
  Widget build(BuildContext context) {
    final hazardProvider = Provider.of<HazardProvider>(context);
    final hazard = hazardProvider.hazards.firstWhere((h) => h.id == hazardId);

    return Scaffold(
      appBar: AppBar(
        title: Text(hazard.id),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hazard.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(hazard.category),
                  backgroundColor: AppTheme.cardBg,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(hazard.severity.name.toUpperCase()),
                  backgroundColor: AppTheme.cardBg,
                  side: BorderSide(
                    color: hazard.severity.index >= 2 ? AppTheme.dangerRed : AppTheme.warningYellow,
                  ),
                ),
              ],
            ),
            const Divider(height: 32, color: Colors.white24),
            _buildDetailRow('Location', hazard.location, Icons.location_on_rounded),
            const SizedBox(height: 12),
            _buildDetailRow('Reported By', hazard.reportedBy, Icons.person_rounded),
            const SizedBox(height: 12),
            _buildDetailRow(
              'Date Logged',
              DateFormat('MMM dd, yyyy - hh:mm a').format(hazard.reportedAt),
              Icons.access_time_rounded,
            ),
            const SizedBox(height: 24),
            const Text('Incident Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12)),
              child: Text(hazard.description, style: const TextStyle(height: 1.4)),
            ),
            const SizedBox(height: 28),
            const Text('Update Incident Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hazard.status == HazardStatus.InProgress ? AppTheme.warningYellow : AppTheme.cardBg,
                    ),
                    onPressed: () => hazardProvider.updateHazardStatus(hazard.id, HazardStatus.InProgress),
                    child: const Text('IN PROGRESS', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hazard.status == HazardStatus.Resolved ? AppTheme.successGreen : AppTheme.cardBg,
                    ),
                    onPressed: () => hazardProvider.updateHazardStatus(hazard.id, HazardStatus.Resolved),
                    child: const Text('RESOLVE', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.textMuted),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(color: AppTheme.textMuted)),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
      ],
    );
  }
}