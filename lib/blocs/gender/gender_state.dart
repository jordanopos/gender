part of 'gender_bloc.dart';

@immutable
abstract class GenderState extends Equatable {}

class GenderInitial extends GenderState {
  @override
  List<Object> get props => [];
}

class GenderLoading extends GenderState {
  @override
  List<Object> get props => [];
}

class GenderLoaded extends GenderState {
  final GenderResult gottenGender;

  GenderLoaded(this.gottenGender);
  @override
  List<Object> get props => [];
}


class GenderError extends GenderState{
  @override
  List<Object> get props => [];
}
