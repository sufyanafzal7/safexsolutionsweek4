import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/inspection_provider.dart';
import '../utils/app_theme.dart';

class AuditChecklistScreen extends StatelessWidget {
  const AuditChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InspectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Safety Audit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => provider.resetChecklist(),
            tooltip: 'Reset Checklist',
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Overall Safety Index', style: TextStyle(color: AppTheme.textMuted)),
                    const SizedBox(height: 4),
                    Text(
                      '${provider.compliancePercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: provider.compliancePercentage >= 80 ? AppTheme.successGreen : AppTheme.dangerRed,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${provider.passedItems} / ${provider.totalItems} Passed',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: provider.items.length,
              itemBuilder: (context, index) {
                final item = provider.items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: SwitchListTile(
                    activeColor: AppTheme.successGreen,
                    inactiveThumbColor: AppTheme.dangerRed,
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(item.category, style: const TextStyle(color: AppTheme.textMuted)),
                    value: item.isPassed,
                    onChanged: (_) => provider.toggleStatus(item.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}