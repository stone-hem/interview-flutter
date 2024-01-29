import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/ui/application/bloc/app_blocs.dart';
import 'package:interview/ui/application/bloc/app_events.dart';
import 'package:interview/ui/application/bloc/app_state.dart';

import 'package:interview/widgets/bottom_bar_pages.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
 Widget build(BuildContext context) {
    return BlocBuilder<AppBlocs, AppState>(builder: (context, state) {
      return Scaffold(
        body: buildPage(state.index),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value) {
            context.read<AppBlocs>().add(ChangeIndexEvent(value));
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blueGrey,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "List",
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: "More",
              icon: Icon(Icons.warning),
            )
          ],
        ),
      );
    });
  }
}
