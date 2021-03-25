import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tmdb/model/movie_trending.dart';

abstract class TrendingState extends Equatable{
  final bool hasReachMax;
  const TrendingState(this.hasReachMax);

  @override
  // TODO: implement props
  List<Object> get props => [hasReachMax];
}
class TrendingLoadingState extends TrendingState{
  TrendingLoadingState(bool hasReachMax) : super(hasReachMax);

}
class TrendingFailureState extends TrendingState{
  TrendingFailureState(bool hasReachMax) : super(hasReachMax);

}
class TrendingSuccess extends TrendingState{
  final List<MovieTrending> movies;
  final bool hasReachMax;
  final int page;
  const TrendingSuccess({
    this.page,
    this.movies,
    this.hasReachMax
  }) : super(false) ;

  TrendingSuccess copyWith({
    int page,
    List<MovieTrending> movies,
    bool hasReachMax
  }) => TrendingSuccess(
      page: page?? this.page,
      movies: movies??this.movies,
      hasReachMax: hasReachMax?? this.hasReachMax
    );

  @override
  // TODO: implement props
  List<Object> get props => [page,movies, hasReachMax];
}