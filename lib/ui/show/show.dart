import 'package:flutter/material.dart';
import 'package:interview/common/constants.dart';
import 'package:interview/models/NewsModel.dart';

class Show extends StatefulWidget {
  const Show({super.key, required this.news});

  final NewsModel news;

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    NewsModel news = widget.news;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(news.title),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "$imageUrl/${news.photo_url}"),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  news.name,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  news.description,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("More on database"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      news.more_url,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
