import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tmdb/model/movie_trending.dart';

abstract class TrendingEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TrendingSwitchDay extends TrendingEvent{
  final int page;

  TrendingSwitchDay(this.page);

  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class TrendingSwitchWeek extends TrendingEvent{}

class TrendingShowMovieInfo extends TrendingEvent{
  final int id;
  final List<MovieTrending> movies;
  TrendingShowMovieInfo({@required this.movies,@required this.id});
  @override
  // TODO: implement props
  List<Object> get props => [id];
}