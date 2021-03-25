import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/trending_bloc/trending_bloc.dart';
import 'package:flutter_tmdb/trending_bloc/trending_event.dart';
import 'package:flutter_tmdb/ui/movie_info_page.dart';
import 'package:flutter_tmdb/ui/trending_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context)=>TrendingBloc()..add(TrendingFetch()),
          child: TrendingPage())
    );
  }
}
