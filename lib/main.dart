import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/category/category_blocs.dart';
import 'package:interview/blocs/category/category_events.dart';
import 'package:interview/blocs/news/news_blocs.dart';
import 'package:interview/blocs/news/news_events.dart';
import 'package:interview/repository/news_categories_repository.dart';
import 'package:interview/repository/news_repository.dart';
import 'package:interview/screens/news_app/bloc/app_blocs.dart';
import 'package:interview/screens/news_app/news_application.dart';

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
        RepositoryProvider(create: (context) => CategoryRepository(),)
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
          )
        ],
        child: const MaterialApp(
          home: NewsApplication(),
        ),
      ),
    );
  }
}
