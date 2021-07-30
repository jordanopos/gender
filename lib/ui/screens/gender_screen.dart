import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podio/blocs/gender/gender_bloc.dart';
import 'package:podio/models/gender.dart';
import 'package:provider/provider.dart';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GenderBloc genderBloc = context.read<GenderBloc>();
    return Scaffold(
      body: BlocBuilder<GenderBloc, GenderState>(
        bloc: genderBloc,
        builder: (context, state) {
          if (state is GenderInitial) {
            controller.clear();
            return GenderInitScreen(
                controller: controller, genderBloc: genderBloc);
          } else if (state is GenderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GenderLoaded) {
            var gottenGender = state.gottenGender;
            return ResultsScreen(gottenGender, genderBloc);
          } else if (state is GenderError) {
            return GenderErrorScreen(genderBloc: genderBloc);
          }
          return Container();
        },
      ),
    );
  }
}

class GenderErrorScreen extends StatelessWidget {
  const GenderErrorScreen({
    Key key,
    @required this.genderBloc,
  }) : super(key: key);

  final GenderBloc genderBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Icon(Icons.error_rounded, color: Colors.white, size: 100),
          Text('This name cannot be parsed'),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: InkWell(
              onTap: () => genderBloc.add(ResetGender()),
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(child: Text('Reset')),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GenderInitScreen extends StatelessWidget {
  const GenderInitScreen({
    Key key,
    @required this.controller,
    @required this.genderBloc,
  }) : super(key: key);

  final TextEditingController controller;
  final GenderBloc genderBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30.0, right: 25, left: 25, bottom: 10),
      child: Container(
          child: Column(children: [
        Expanded(
          child: Container(
              child: Column(
            children: [
              Container(
                  child: Image.asset('assets/images/gender.png',
                      color: Colors.white, height: 200)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  cursorColor: Colors.white,
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Enter name here',
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      border: UnderlineInputBorder()),
                ),
              ),
            ],
          )),
        ),
        Expanded(
          child: Container(
              child: Column(children: [
            Spacer(),
            InkWell(
              onTap: () => genderBloc.add(GetGender(controller.text)),
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                  //     border: Border.all(width: 1.1, color: Colors.white),
                  color: Colors.blue,
                ),
                child: Center(child: Text('Predict Gender')),
              ),
            )
          ])),
        ),
      ])),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final GenderResult gottenGender;
  final GenderBloc genderBloc;

  ResultsScreen(this.gottenGender, this.genderBloc);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                child: Column(
              children: [
                Spacer(),
                Text('Hmm.. We think ${gottenGender.name ?? ''} is:'),
                SizedBox(height: 10),
                Text(
                    gottenGender.gender[0].toUpperCase() +
                            gottenGender.gender.substring(1) ??
                        '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    )),
                Spacer(),
              ],
            )),
          ),
          Expanded(
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text('Additonal Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18))),
                ListTile(
                    leading: Text('Name Given:'),
                    trailing: Text(gottenGender.name ?? '')),
                ListTile(
                    leading: Text('Gender count:'),
                    trailing: Text(gottenGender.count.toString() ?? '')),
                ListTile(
                  leading: Text('Probability:'),
                  trailing: Text(gottenGender.probability.toString() ?? ''),
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: InkWell(
                    onTap: () => genderBloc.add(ResetGender()),
                    child: Container(
                      height: 33,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Center(child: Text('Reset')),
                    ),
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    ));
  }
}
