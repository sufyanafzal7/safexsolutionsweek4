import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hazard_model.dart';
import '../providers/hazard_provider.dart';
import '../utils/app_theme.dart';

class ReportHazardScreen extends StatefulWidget {
  const ReportHazardScreen({super.key});

  @override
  State<ReportHazardScreen> createState() => _ReportHazardScreenState();
}

class _ReportHazardScreenState extends State<ReportHazardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Electrical Safety';
  HazardSeverity _selectedSeverity = HazardSeverity.Medium;

  final List<String> _categories = [
    'Electrical Safety',
    'Chemical & Slip Hazard',
    'Fire Safety',
    'Machinery Risk',
    'Structural Hazard',
    'PPE Violation',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newHazard = HazardModel(
        id: 'HZ-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        title: _titleController.text.trim(),
        category: _selectedCategory,
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        severity: _selectedSeverity,
        status: HazardStatus.Open,
        reportedAt: DateTime.now(),
        reportedBy: 'Operational Field User',
      );

      Provider.of<HazardProvider>(context, listen: false).addHazard(newHazard);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hazard report successfully submitted & synced locally!'),
          backgroundColor: AppTheme.successGreen,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Hazard Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Hazard Title'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Specific Location'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter location details' : null,
              ),
              const SizedBox(height: 16),
              const Text('Severity Level', style: TextStyle(color: AppTheme.textMuted)),
              const SizedBox(height: 8),
              SegmentedButton<HazardSeverity>(
                segments: const [
                  ButtonSegment(value: HazardSeverity.Low, label: Text('Low')),
                  ButtonSegment(value: HazardSeverity.Medium, label: Text('Med')),
                  ButtonSegment(value: HazardSeverity.High, label: Text('High')),
                  ButtonSegment(value: HazardSeverity.Critical, label: Text('Crit')),
                ],
                selected: {_selectedSeverity},
                onSelectionChanged: (set) => setState(() => _selectedSeverity = set.first),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Detailed Description & Observations'),
                validator: (val) => val == null || val.isEmpty ? 'Please add detailed descriptions' : null,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _submitForm,
                  child: const Text('SUBMIT REPORT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}