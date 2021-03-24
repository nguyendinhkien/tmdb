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
class TrendingSuccess extends TrendingState{
  final List<MovieTrending> movies;
  final bool hasReachMax;
  const TrendingSuccess({this.movies, this.hasReachMax});

  TrendingSuccess copyWith({
    movies,
    hasReachMax
  }){
    return TrendingSuccess(
      movies: movies??this.movies,
      hasReachMax: hasReachMax?? this.hasReachMax
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [movies];
}