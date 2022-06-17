class Movies {
  String image, url, title;
  String year;
  Movies(
      {required this.image,
      required this.url,
      required this.title,
      required this.year});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      image: json['image'] ?? "",
      url: json['link'] ?? "",
      title: json['title'] ?? "",
      year: json['year'] ?? "0000",
    );
  }
}
