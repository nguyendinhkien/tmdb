import 'package:flutter_tmdb/persistence/trending_api_provider.dart';

class TrendingRepository{
  TrendingApiProvider api = TrendingApiProvider();
  Future<TrendingResponse> getTrendingDay() => api.getTrendingDay();
  Future<TrendingResponse> getTrendingWeek() => api.getTrendingWeek();
}