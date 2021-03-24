import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_tmdb/persistence/trending_api_provider.dart';
import 'package:flutter_tmdb/trending_bloc/trending_event.dart';
import 'package:flutter_tmdb/trending_bloc/trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState>{

  final TrendingApiProvider provider = TrendingApiProvider();
  TrendingBloc() : super(TrendingInitialState());
  static final page = 1;


  @override
  Stream<TrendingState> mapEventToState(TrendingEvent event) async*{
    if(event is TrendingSwitchDay){
      yield* _mapSwitchDayToState(event);
    } else if(event is TrendingSwitchWeek){
      yield* _mapSwitchWeekToState();
    }
  }

  Stream<TrendingState> _mapSwitchDayToState(TrendingSwitchDay event) async*{
    yield TrendingLoadingState();

    TrendingResponse response = await provider.getTrendingDay(event.page);

    if(response.error ==''){
      yield TrendingSuccess(response.results);
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
      yield TrendingSuccess(response.results);
    }
    else{
      yield TrendingFailureState();
    }
  }

}