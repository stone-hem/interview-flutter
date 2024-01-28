import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/screens/news_app/bloc/app_blocs.dart';
import 'package:interview/screens/news_app/news_application.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBlocs()),
      ],
      child: const MaterialApp(
        home: NewsApplication(),
      ),
    );
  }
}
