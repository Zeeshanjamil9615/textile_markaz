class TextileAd {
  TextileAd({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.mode,
    required this.city,
    required this.contactPhone,
    this.price,
    required this.createdAt,
    required this.expiryDate,
    this.imagePaths = const [],
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String mode;
  final String city;
  final String contactPhone;
  final String? price;
  final DateTime createdAt;
  final DateTime expiryDate;
  final List<String> imagePaths;
}
