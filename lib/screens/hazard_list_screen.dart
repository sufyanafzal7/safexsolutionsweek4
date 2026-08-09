import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hazard_model.dart';
import '../providers/hazard_provider.dart';
import '../utils/app_theme.dart';
import 'incident_detail_screen.dart';

class HazardListScreen extends StatefulWidget {
  const HazardListScreen({super.key});

  @override
  State<HazardListScreen> createState() => _HazardListScreenState();
}

class _HazardListScreenState extends State<HazardListScreen> {
  String _searchQuery = '';
  HazardStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final hazardProvider = Provider.of<HazardProvider>(context);

    final filteredHazards = hazardProvider.hazards.where((h) {
      final matchesSearch = h.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          h.location.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _statusFilter == null || h.status == _statusFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hazard Log & Incidents'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: const InputDecoration(
                hintText: 'Search hazards or locations...',
                prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textMuted),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _statusFilter == null,
                  onSelected: (_) => setState(() => _statusFilter = null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Open'),
                  selected: _statusFilter == HazardStatus.Open,
                  onSelected: (_) => setState(() => _statusFilter = HazardStatus.Open),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('In Progress'),
                  selected: _statusFilter == HazardStatus.InProgress,
                  onSelected: (_) => setState(() => _statusFilter = HazardStatus.InProgress),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Resolved'),
                  selected: _statusFilter == HazardStatus.Resolved,
                  onSelected: (_) => setState(() => _statusFilter = HazardStatus.Resolved),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredHazards.isEmpty
                ? const Center(
              child: Text('No hazards found.', style: TextStyle(color: AppTheme.textMuted)),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredHazards.length,
              itemBuilder: (context, index) {
                final item = filteredHazards[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('${item.category}\n📍 ${item.location}'),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildStatusBadge(item.status),
                        const SizedBox(height: 4),
                        Text(
                          item.severity.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: item.severity.index >= 2 ? AppTheme.dangerRed : AppTheme.warningYellow,
                          ),
                        ),
                      ],
                    ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(HazardStatus status) {
    Color bg;
    String text;
    switch (status) {
      case HazardStatus.Open:
        bg = AppTheme.dangerRed;
        text = 'OPEN';
        break;
      case HazardStatus.InProgress:
        bg = AppTheme.warningYellow;
        text = 'IN PROGRESS';
        break;
      case HazardStatus.Resolved:
        bg = AppTheme.successGreen;
        text = 'RESOLVED';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: bg),
      ),
    );
  }
}