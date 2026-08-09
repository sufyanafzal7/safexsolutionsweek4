import 'dart:convert';

enum HazardSeverity { Low, Medium, High, Critical }
enum HazardStatus { Open, InProgress, Resolved }

class HazardModel {
  final String id;
  final String title;
  final String category;
  final String location;
  final String description;
  final HazardSeverity severity;
  HazardStatus status;
  final DateTime reportedAt;
  final String reportedBy;

  HazardModel({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    required this.severity,
    required this.status,
    required this.reportedAt,
    required this.reportedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'description': description,
      'severity': severity.index,
      'status': status.index,
      'reportedAt': reportedAt.toIso8601String(),
      'reportedBy': reportedBy,
    };
  }

  factory HazardModel.fromMap(Map<String, dynamic> map) {
    return HazardModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      location: map['location'],
      description: map['description'],
      severity: HazardSeverity.values[map['severity']],
      status: HazardStatus.values[map['status']],
      reportedAt: DateTime.parse(map['reportedAt']),
      reportedBy: map['reportedBy'],
    );
  }

  String toJson() => json.encode(toMap());
  factory HazardModel.fromJson(String source) => HazardModel.fromMap(json.decode(source));
}