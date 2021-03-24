import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tmdb/model/movie_trending.dart';

abstract class TrendingState extends Equatable{
  const TrendingState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TrendingInitialState extends TrendingState{
}
class TrendingLoadingState extends TrendingState{}
class TrendingFailureState extends TrendingState{}
class TrendingShowedInfo extends TrendingState{
  final int id;
  final List<MovieTrending> movies;

  TrendingShowedInfo({@required this.movies,@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [movies,id];
}
class TrendingTodayState extends TrendingState{
  final List<MovieTrending> movies;

  const TrendingTodayState(this.movies);

  @override
  // TODO: implement props
  List<Object> get props => [movies];
}

class TrendingThisWeekState extends TrendingState{
  final List<MovieTrending> movies;

  const TrendingThisWeekState(this.movies);

  @override
  // TODO: implement props
  List<Object> get props => [movies];
}

class MovieInfoState extends TrendingState{
  final int id;

  const MovieInfoState(this.id);

  @override
  // TODO: implement props
  List<Object> get props => [id];
}