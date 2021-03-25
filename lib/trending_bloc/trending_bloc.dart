

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_tmdb/model/movie_trending.dart';
import 'package:flutter_tmdb/persistence/trending_api_provider.dart';
import 'package:flutter_tmdb/persistence/trending_repository.dart';
import 'package:flutter_tmdb/trending_bloc/trending_event.dart';
import 'package:flutter_tmdb/trending_bloc/trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState>{
  TrendingBloc() : super(TrendingLoadingState(false));
  static final page = 1;
  final repository = TrendingRepository();

  @override
  Stream<TrendingState> mapEventToState(TrendingEvent event) async*{
    final currentState = state;
    if(event is TrendingFetch&& !_hasReachMax(currentState)){
      try{
        if( currentState is TrendingLoadingState){
          log('initial');
          final movies = await _fetchMovies(1);
          yield TrendingSuccess(page: 1,movies: movies, hasReachMax: false);
        }
        else if(currentState is TrendingSuccess){
          log('load more');
          int pageNext = currentState.page+1;
          final movies = await _fetchMovies(pageNext);
          yield movies.isEmpty
              ? currentState.copyWith(hasReachMax: true)
              : TrendingSuccess(movies: currentState.movies+movies, hasReachMax: false, page: pageNext);
        }
      }
      catch(e){
        log('$e');
        yield TrendingFailureState(false);
      }
    }
  }

  bool _hasReachMax(TrendingState currentState) =>
      state is TrendingSuccess && state.hasReachMax;

  Future<List<MovieTrending>> _fetchMovies(int page) async{
    TrendingResponse response = await repository.getTrending(page);
    if(response.error ==''){
      return response.results;
    }
    else{
      throw Exception('error fetching');
    }
  }
}