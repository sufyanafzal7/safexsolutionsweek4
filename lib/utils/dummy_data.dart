import '../models/hazard_model.dart';
import '../models/inspection_model.dart';

class DummyData {
  static List<HazardModel> get initialHazards => [
    HazardModel(
      id: 'HZ-101',
      title: 'Exposed High-Voltage Wiring',
      category: 'Electrical Safety',
      location: 'Sector B - Main Generator Room',
      description: 'Insulation damaged on main distribution feed. Risk of electrical shock or short circuit during operation.',
      severity: HazardSeverity.Critical,
      status: HazardStatus.Open,
      reportedAt: DateTime.now().subtract(const Duration(hours: 3)),
      reportedBy: 'Alex Rivera (Safety Inspector)',
    ),
    HazardModel(
      id: 'HZ-102',
      title: 'Oil Spill Near Assembly Line 3',
      category: 'Chemical & Slip Hazard',
      location: 'Warehouse Floor - Gate 4',
      description: 'Hydraulic fluid leaked from Forklift #12. Slippery floor surface created across the main pedestrian corridor.',
      severity: HazardSeverity.Medium,
      status: HazardStatus.InProgress,
      reportedAt: DateTime.now().subtract(const Duration(hours: 8)),
      reportedBy: 'Sarah Chen (Site Supervisor)',
    ),
    HazardModel(
      id: 'HZ-103',
      title: 'Expired Fire Extinguisher',
      category: 'Fire Safety',
      location: 'Building A - 2nd Floor Breakroom',
      description: 'Type CO2 extinguisher pressure gauge is in the red zone and annual inspection tag expired 2 months ago.',
      severity: HazardSeverity.Low,
      status: HazardStatus.Resolved,
      reportedAt: DateTime.now().subtract(const Duration(days: 2)),
      reportedBy: 'David Miller (Technician)',
    ),
  ];

  static List<InspectionItem> get defaultChecklist => [
    InspectionItem(id: '1', title: 'Emergency exit doors unlocked and unobstructed', category: 'Fire Safety'),
    InspectionItem(id: '2', title: 'Personal Protective Equipment (PPE) worn by all personnel', category: 'Personal Safety'),
    InspectionItem(id: '3', title: 'First Aid kits fully stocked and accessible', category: 'Medical'),
    InspectionItem(id: '4', title: 'Scaffolding railings secured and locked in position', category: 'Height Safety'),
    InspectionItem(id: '5', title: 'Heavy machinery emergency kill switches functional', category: 'Machinery'),
    InspectionItem(id: '6', title: 'Chemical storage containers labeled and sealed', category: 'Hazmat'),
  ];
}