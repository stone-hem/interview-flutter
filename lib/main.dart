import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/category/category_blocs.dart';
import 'package:interview/blocs/category/category_events.dart';
import 'package:interview/blocs/news/news_blocs.dart';
import 'package:interview/blocs/news/news_events.dart';
import 'package:interview/blocs/tab_news/tab_news_blocs.dart';
import 'package:interview/blocs/tab_news/tab_news_events.dart';
import 'package:interview/repository/news_categories_repository.dart';
import 'package:interview/repository/news_repository.dart';
import 'package:interview/repository/tab_news_categories_repository.dart';
import 'package:interview/ui/application/bloc/app_blocs.dart';
import 'package:interview/ui/application/application.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => NewsRepository(),),
        RepositoryProvider(create: (context) => CategoryRepository(),),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppBlocs()),
          BlocProvider(
            create: (context) => NewsBloc(
              RepositoryProvider.of<NewsRepository>(context),
            )..add(LoadNewsEvent())
          ),
          BlocProvider(
              create: (context) => CategoryBloc(
                RepositoryProvider.of<CategoryRepository>(context),
              )..add(LoadCategoryEvent())
          ),
          BlocProvider(
              create: (context) => TabNewsBloc(
                RepositoryProvider.of<TabNewsRepository>(context),
              )..add(LoadTabNewsEvent())
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Application(),
        ),
      ),
    );
  }
}
