import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_tmdb/persistence/trending_api_provider.dart';
import 'package:flutter_tmdb/trending_bloc/trending_event.dart';
import 'package:flutter_tmdb/trending_bloc/trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState>{

  final TrendingApiProvider provider = TrendingApiProvider();
  TrendingBloc() : super(TrendingInitialState());


  @override
  Stream<TrendingState> mapEventToState(TrendingEvent event) async*{
    if(event is TrendingSwitchDay){
      yield* _mapSwitchDayToState();
    } else if(event is TrendingSwitchWeek){
      yield* _mapSwitchWeekToState();
    } else if(event is TrendingShowMovieInfo){
      yield TrendingShowedInfo(movies:event.movies,id: event.id);
    }
  }

  Stream<TrendingState> _mapSwitchDayToState() async*{
    yield TrendingLoadingState();

    TrendingResponse response = await provider.getTrendingDay();

    if(response.error ==''){
      yield TrendingTodayState(response.results);
    }
    else{
      yield TrendingFailureState();
    }
  }

  Stream<TrendingState> _mapSwitchWeekToState() async*{
    yield TrendingLoadingState();
    TrendingApiProvider provider = TrendingApiProvider();
    TrendingResponse response = await provider.getTrendingWeek();

    if(response.error ==''){
      log('week');
      yield TrendingTodayState(response.results);
    }
    else{
      yield TrendingFailureState();
    }
  }

}