
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
                          Container(
                            width: 250,
                              child: Text('${movie.title}', style: TextStyle(fontWeight: FontWeight.bold),)),
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
    if(trendingState is TrendingLoadingState){
      //trendingBloc.add(TrendingFetch());
      return SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator()
      );
    }
    else if(trendingState is TrendingSuccess){
      return Expanded(
        child:ListView.builder(
            itemCount: trendingState.hasReachMax
            ? trendingState.movies.length
            : trendingState.movies.length + 1,
            itemBuilder:(context, index) {
              return index >= trendingState.movies.length
                ? BottomLoader()
                : _itemTrending(trendingState.movies[index], context);
            },
          controller: _scrollController,
        ),
      );
    }
    return Text('Loading fail');
  }
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  TrendingBloc _trendBloc;

  _onScroll(){
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if(maxScroll - currentScroll <= _scrollThreshold){
      _trendBloc.add(TrendingFetch());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    _trendBloc = BlocProvider.of<TrendingBloc>(context);
  }
  @override
  void dispose() {
    _trendBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: BlocBuilder(
              bloc: _trendBloc,
              builder:(context, state)=> Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                    children:[
                      _topBar(BlocProvider.of<TrendingBloc>(context)),
                      _buildMovieItem(BlocProvider.of<TrendingBloc>(context)),
                    ]
                ),
              ),
          ),
    );
  }
}

class BottomLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
          ),
        ),
      ),
    );
  }
}
