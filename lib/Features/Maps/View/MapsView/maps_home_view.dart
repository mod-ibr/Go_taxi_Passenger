import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services_locator.dart' as di;
import '../../ViewModel/MapsCubit/maps_cubit.dart';
import '../Widgets/MapsHomeViewWidgets/maps_home_view_body.dart';
import '../Widgets/MapsHomeViewWidgets/maps_home_view_drawer.dart';

class MapsHomeView extends StatelessWidget {
  const MapsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: globalKey,
      drawer: MapsHomeViewDrawer(width: width, height: height),
      body: MapsHomeViewBody(
          height: height, width: width, globalKey: globalKey),
    );
  }
}
