import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/news/news_blocs.dart';
import 'package:interview/blocs/news/news_states.dart';
import 'package:interview/common/constants.dart';
import 'package:interview/models/NewsModel.dart';
import 'package:interview/ui/search/search.dart';
import 'package:interview/ui/show/show.dart';

class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsStates>(builder: (context, state) {
      if (state is NewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NewsLoadedState) {
        List<NewsModel> newsList = state.news;
        return SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Search())),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "type your search",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: PageView.builder(
                          itemCount: newsList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        Show(news: newsList[index])));
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "$imageUrl/${newsList[index].photo_url}"),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      newsList[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newsList[index].description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is NewsErrorState) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return const Center(
          child: Text("Unknown"),
        );
      }
    });
  }
}
