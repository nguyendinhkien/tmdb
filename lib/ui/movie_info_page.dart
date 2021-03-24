import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/info_bloc/movie_bloc.dart';
import 'package:flutter_tmdb/info_bloc/movie_event.dart';
import 'package:flutter_tmdb/info_bloc/movie_state.dart';
import 'package:flutter_tmdb/model/movie_info.dart';

class MovieInfoPage extends StatefulWidget{
  final int id;
  const MovieInfoPage({Key key, this.id}) : super(key: key);
  @override
  _MovieInfoPageState createState() => _MovieInfoPageState(this.id);
}

class _MovieInfoPageState extends State<MovieInfoPage>{
  final int id;

  _MovieInfoPageState(this.id);

  @override
  Widget build(BuildContext context) {
    _buildInfo(movieBloc){
      final state = movieBloc.state;
      print(state.toString());
      if(state is MovieLoading){
        movieBloc.add(LoadMovie(id));
        return Center(
          child: SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator()
          ),
        );
      }else if(state is MovieSuccess){
        return _MovieInfo(state.movie);
      }
      return Center(
        child: SizedBox(
            height: 48,
            width: 48,
            child: CircularProgressIndicator()
        ),
      );
    }
    return BlocProvider(
      create: (context)=> MovieBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(child: SizedBox(height: 15,)),
              BlocBuilder<MovieBloc, MovieState>(
                builder:(context, state)=>_buildInfo(BlocProvider.of<MovieBloc>(context))
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieInfo extends StatelessWidget {
  final MovieInfo movie;
  _MovieInfo(this.movie);

  _buildPoster(){
    return Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://www.themoviedb.org/t/p/w220_and_h330_face${movie.posterPath}"),
              //fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.circular(10)
        )
    );
  }
  _getListGenres(){
    final buttonGenres = <Widget>[];
    for(var genre in movie.genres){
      buttonGenres.add(Text('${genre.name}', style: TextStyle(fontSize: 12, ),));
    }
    return buttonGenres;
  }
  _buildScore() {
    final star = <Widget>[];

    for(var i = 0; i< movie.voteAverage.round(); i++){
      star.add(Icon(Icons.star, size: 20,));
    }
    for(var i = 0; i< (10-movie.voteAverage.round()); i++){
      star.add(Icon(Icons.star_border, size: 20,));
    }
    star.add(Text('(${movie.voteAverage}/10)', style: TextStyle(fontSize: 12),));
    return star;
  }
  _buildDetail(){
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${movie.title}', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _getListGenres(),
          ),
          SizedBox(height: 8,),
          Wrap(
            children: _buildScore(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPoster(),
                _buildDetail(),
              ],
            ),
          Divider(color: Colors.grey,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // _buildScore(),
              // _build
            ],
          ),
          SizedBox(height: 20,),
          Text('Overview', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text('${movie.overview}'),
        ],
      ),
      );
  }


}