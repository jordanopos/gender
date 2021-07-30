part of 'gender_bloc.dart';

@immutable
abstract class GenderEvent extends Equatable {}

class GetGender extends GenderEvent {
  final String name;

  GetGender(this.name);
  @override
  List<Object> get props => null;
}

class ResetGender extends GenderEvent {
  @override
  List<Object> get props => null;
}
