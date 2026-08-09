class InspectionItem {
  final String id;
  final String title;
  final String category;
  bool isPassed;

  InspectionItem({
    required this.id,
    required this.title,
    required this.category,
    this.isPassed = true,
  });
}