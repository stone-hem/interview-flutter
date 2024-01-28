import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/news/news_blocs.dart';
import 'package:interview/blocs/news/news_states.dart';
import 'package:interview/models/NewsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsStates>(builder: (context, state) {
      if (state is NewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }else if(state is NewsLoadedState){
        List<NewsModel> newsList=state.news;
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          itemCount: newsList.length,
            itemBuilder: (_,index){
          return Text(newsList[index].name);
        });
      }else if(state is NewsErrorState){
        return Center(child: Text(state.error),);
      }else{
        return Center(child: Text("Unknown"),);
      }
    });
  }
}
