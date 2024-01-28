class NewsModel {
  final int id;
  final int category_id;
  final String name;
  final String title;
  final String description;
  final String photo_url;
  final String more_url;
  final String created_at;
  final String updated_at;

  NewsModel(
      {required this.id,
      required this.category_id,
      required this.name,
      required this.title,
      required this.description,
      required this.photo_url,
      required this.more_url,
      required this.created_at,
      required this.updated_at});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      category_id: json['category_id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      photo_url: json['photo_url'],
      more_url: json['more_url'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
