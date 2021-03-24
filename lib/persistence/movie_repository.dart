import 'package:flutter_tmdb/model/movie_info.dart';
import 'package:flutter_tmdb/persistence/movie_provider.dart';

class MovieRepository{

  MovieProvider api = MovieProvider();

  Future<MovieInfo> getMovie(id) => api.getMovie(id);
}