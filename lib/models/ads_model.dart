class Ads {
  final String id;
  final String title;
  final String description;
  final double price;
  final String contactNumber;
  final String updated;

  Ads({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.contactNumber,
    required this.updated,
  });

  factory Ads.fromJson(Map<String, dynamic> json) {
    return Ads(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      contactNumber: json['mobile'],
      updated: json['createdAt'],
    );
  }
}
