class MoviesModel {
  MoviesModel({
    required this.id,
    required this.title,
    required this.posterURL,
    required this.imdbId,
  });
  late final int id;
  late final String title;
  late final String posterURL;
  late final String imdbId;

  MoviesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    posterURL = json['posterURL'];
    imdbId = json['imdbId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['posterURL'] = posterURL;
    data['imdbId'] = imdbId;
    return data;
  }
}
