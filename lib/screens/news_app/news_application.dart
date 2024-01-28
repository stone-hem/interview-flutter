import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/screens/news_app/bloc/app_blocs.dart';
import 'package:interview/screens/news_app/bloc/app_events.dart';
import 'package:interview/screens/news_app/bloc/app_state.dart';

import 'package:interview/widgets/bottom_bar_pages.dart';

class NewsApplication extends StatefulWidget {
  const NewsApplication({super.key});

  @override
  State<NewsApplication> createState() => _NewsApplicationState();
}

class _NewsApplicationState extends State<NewsApplication> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBlocs,AppState>(builder: (context,state){

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(25),
              child: buildPage(state.index)
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value){
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
