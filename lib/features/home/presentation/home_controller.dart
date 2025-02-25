library home_library;

import 'package:dukaandaar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes.dart';
import '../../../core/widget_view_base.dart';
import '../../../core/widgets/CircularCard.dart';
import '../../auth/data/models/user_model.dart';

part 'home_screen.dart';

class HomeScreenController extends StatefulWidget {
  const HomeScreenController({super.key});

  @override
  State<HomeScreenController> createState() => HomeScreenControllerState();
}

class HomeScreenControllerState extends State<HomeScreenController> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadHome());
  }

  @override
  Widget build(BuildContext context) => HomeScreenUI(this);

  void handleApiResponse(Object? state) {}
}
