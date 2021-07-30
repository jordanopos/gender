import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podio/blocs/gender/gender_bloc.dart';
import 'package:podio/repository/name_repository.dart';
import 'package:podio/ui/screens/gender_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenderBloc(genderRepo: GenderImpl()),
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Circle',
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xff00001f),
          ),
          home: GenderScreen(),
          title: 'Gender predictor bloc app'),
    );
  }
}
