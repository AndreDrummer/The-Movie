class MovieModel {
  int id;
  bool adult;
  bool video;
  String title;
  int voteCount;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  List<int> genreIds;
  double voteAverage;
  String backdropPath;
  String originalTitle;
  String originalLanguage;

  MovieModel({
    this.id,
    this.video,
    this.title,
    this.adult,
    this.overview,
    this.genreIds,
    this.voteCount,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
    this.backdropPath,
    this.originalTitle,
    this.originalLanguage,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adult = json['adult'];
    title = json['title'];
    video = json['video'];
    overview = json['overview'];
    voteCount = json['vote_count'];
    popularity = double.parse(json['popularity'].toString()) / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    backdropPath = json['backdrop_path'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    voteAverage = double.parse(json['vote_average'].toString()) / 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['title'] = this.title;
    data['video'] = this.video;
    data['overview'] = this.overview;
    data['genre_ids'] = this.genreIds;
    data['vote_count'] = this.voteCount;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;
    data['release_date'] = this.releaseDate;
    data['backdrop_path'] = this.backdropPath;
    data['original_title'] = this.originalTitle;
    data['original_language'] = this.originalLanguage;
    return data;
  }
}
