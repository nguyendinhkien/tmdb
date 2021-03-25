import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_tmdb/model/movie_trending.dart';

class TrendingApiProvider{
  final _baseUrl = "https://api.themoviedb.org/3/trending/movie/";
  final _apiKey = "b25347c1f257be0e30b03a1ae9ea9053";
  final _dio = Dio();

  Future<TrendingResponse> getTrendingDay(page) async{
    try{
      Response response;
      response = await _dio.get(_baseUrl+"day", queryParameters: {"api_key": _apiKey,'page': page});
      return TrendingResponse.fromJson(response.data);
    }catch(error){
      return TrendingResponse.withError(error);
    }
  }
  Future<TrendingResponse> getTrendingWeek() async{
    try{
      Response response;
      response = await _dio.get(_baseUrl+"week", queryParameters: {"api_key": _apiKey});
      return TrendingResponse.fromJson(response.data);
    }catch(error){
      return TrendingResponse.withError(error);
    }
  }

}

class TrendingResponse {
  int page;
  List<MovieTrending> results;
  int totalPages;
  int totalResults;
  String error;

  TrendingResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  TrendingResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results =(json['results'] as List).map((e) => new MovieTrending.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    error ='';
  }

  TrendingResponse.withError(String errorValue){
    results = <MovieTrending>[];
    error = errorValue;
  }
}