import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadMovie extends MovieEvent{
  final int id;

  LoadMovie(this.id);
  @override
  // TODO: implement props
  List<Object> get props => [id];
}