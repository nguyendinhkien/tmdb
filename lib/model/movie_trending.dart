class MovieTrending {
  int id;
  String releaseDate;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int voteCount;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  String title;
  bool video;
  double voteAverage;
  String overview;
  double popularity;
  String mediaType;

  MovieTrending(
      {this.id,
        this.releaseDate,
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.voteCount,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.title,
        this.video,
        this.voteAverage,
        this.overview,
        this.popularity,
        this.mediaType});

  MovieTrending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    releaseDate = json['release_date'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    voteCount = json['vote_count'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['release_date'] = this.releaseDate;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['vote_count'] = this.voteCount;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}