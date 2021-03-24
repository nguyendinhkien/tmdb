
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/trending_bloc/trending_bloc.dart';
import 'package:flutter_tmdb/trending_bloc/trending_event.dart';
import 'package:flutter_tmdb/trending_bloc/trending_state.dart';
import 'package:flutter_tmdb/ui/movie_info_page.dart';


class TrendingPage extends StatefulWidget{
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage>{
  _topBar(trendingBloc){
    //final trendingState = trendingBloc.state;
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Trending', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),
          ElevatedButton(onPressed: (){
            trendingBloc.add(TrendingSwitchWeek());
          }, child: Text('Week'))
        ],
      ),
    );
  }

  _itemTrending(movie, context){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieInfoPage(id: movie.id)));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://www.themoviedb.org/t/p/w220_and_h330_face${movie.posterPath}"),
                              //fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('${movie.title}', style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Text('Release: ${movie.releaseDate}'),
                          SizedBox(height: 8,),
                          Text('User Score: ${movie.voteAverage}'),
                          SizedBox(height: 8,),
                        ],
                      ),
                    )
                  ],
                ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
  _buildMovieItem(trendingBloc){

    final trendingState = trendingBloc.state;

    //print(trendingState.toString());
    if(trendingState is TrendingInitialState) {
      trendingBloc.add(TrendingSwitchDay());
    }
    else if(trendingState is TrendingLoadingState){
      return SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator()
      );
    }
    else if(trendingState is TrendingTodayState||trendingState is TrendingThisWeekState||trendingState is TrendingShowedInfo){
      return Expanded(
        child:ListView.builder(
            itemCount: trendingState.movies.length,
            itemBuilder:(context, index)=> _itemTrending(trendingState.movies[index], context)
        ),
      );
    }
    return Center(
      child: SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator()
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>TrendingBloc(),
      child: Scaffold(
            body: Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                  children:[
                    BlocBuilder<TrendingBloc, TrendingState>(
                      builder: (context, state)=>_topBar(BlocProvider.of<TrendingBloc>(context)),
                    ),
                    BlocBuilder<TrendingBloc, TrendingState>(
                      builder: (context, state)=>_buildMovieItem(BlocProvider.of<TrendingBloc>(context)),
                    ),
                  ]
              ),
            ),
          ),
    );
  }
}
