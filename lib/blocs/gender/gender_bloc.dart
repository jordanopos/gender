import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:podio/models/gender.dart';
import 'package:podio/repository/name_repository.dart';

part 'gender_event.dart';
part 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvent, GenderState> {
  final GenderRepo genderRepo;
  GenderBloc({this.genderRepo}) : super(GenderInitial());

  @override
  Stream<GenderState> mapEventToState(GenderEvent event) async* {
    if (event is GetGender) {
      yield GenderLoading();

      try {
        GenderResult gottenGender = await genderRepo.getGender(event.name);

        if (gottenGender.gender == null) {
          yield GenderError();
        } else {
          yield GenderLoaded(gottenGender);
        }
      } catch (e) {
        yield GenderError();
      }
    } else if (event is ResetGender) {
      yield GenderInitial();
    }
  }
}
