import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/model/movie_info.dart';
import 'package:flutter_tmdb/persistence/movie_repository.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{

  MovieBloc() : super(MovieLoading());
  final repository = MovieRepository();
  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async*{
    if(event is LoadMovie){
      yield* _mapMovieLoadedToState(event);
    }
  }

  Stream<MovieState> _mapMovieLoadedToState(LoadMovie event) async* {
    MovieInfo movie = await repository.getMovie(event.id);
    if(movie.error ==''){
      yield MovieSuccess(movie);
    }
    else{
      print('err: ${movie.error}');
      yield MovieFailure();
    }
  }
}