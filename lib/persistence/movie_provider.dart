import 'package:dio/dio.dart';
import 'package:flutter_tmdb/model/movie_info.dart';

class MovieProvider{
  final _baseUrl = "https://api.themoviedb.org/3/movie/";
  final _apiKey = "b25347c1f257be0e30b03a1ae9ea9053";
  final _dio = Dio();
  Future<MovieInfo> getMovie(id) async{
    try{
      Response response;
      response = await _dio.get(_baseUrl+"$id", queryParameters: {"api_key": _apiKey});
      return MovieInfo.fromJson(response.data);
    }catch(error){
      return MovieInfo.withError("$error");
    }
  }
}
