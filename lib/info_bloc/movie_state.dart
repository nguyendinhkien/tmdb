import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb/model/movie_info.dart';

abstract class MovieState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieLoading extends MovieState{}

class MovieSuccess extends MovieState{
  final MovieInfo movie;

  MovieSuccess(this.movie);

  @override
  // TODO: implement props
  List<Object> get props => [movie];
}

class MovieFailure extends MovieState{}