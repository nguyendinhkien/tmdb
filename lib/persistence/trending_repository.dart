import 'package:flutter_tmdb/persistence/trending_api_provider.dart';

class TrendingRepository{
  TrendingApiProvider api = TrendingApiProvider();
  Future<TrendingResponse> getTrending(page) => api.getTrendingDay(page);
}