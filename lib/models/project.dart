class Project {
  final String title;
  final String type;
  final String localeType;
  final String description;
  final String slug;

  Project({
    required this.title,
    required this.type,
    required this.localeType,
    required this.description,
    required this.slug,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String,
      type: json['type'] as String,
      localeType: json['locale_type'] as String,
      description: json['description'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'locale_type': localeType,
      'description': description,
      'slug': slug,
    };
  }
} 