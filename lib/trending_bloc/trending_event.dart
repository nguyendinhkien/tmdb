import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tmdb/model/movie_trending.dart';

abstract class TrendingEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TrendingFetch extends TrendingEvent{
  TrendingFetch();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
