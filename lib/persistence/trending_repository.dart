import 'package:flutter_tmdb/persistence/trending_api_provider.dart';

class TrendingRepository{
  TrendingApiProvider api = TrendingApiProvider();
  Future<TrendingResponse> getTrendingDay(page) => api.getTrendingDay(page);
  Future<TrendingResponse> getTrendingWeek() => api.getTrendingWeek();
}