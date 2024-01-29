import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:interview/blocs/category/category_blocs.dart';
import 'package:interview/blocs/category/category_states.dart';
import 'package:interview/models/TabNewsModel.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryStates>(builder: (context, state) {
      if (state is CategoryLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is CategoryLoadedState) {
        TabController _tabController =
        TabController(length: state.category.length, vsync: this);
        List<Widget> tabs = [];
        List<Widget> tabViews = [];
        tabs = state.category.map((category) {
          return Tab(
            child: Container(
              width: 60,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(category.name),
            ),
          );
        }).toList();

        Future<List<TabNewsModel>> fetchTabNews(int id) async {
          String uri = "http://127.0.0.1:8000/api/categories/$id";
          final response = await http.get(Uri.parse(uri));

          if (response.statusCode == 200) {
            final List<dynamic> result = jsonDecode(response.body);
            return result.map((e) => TabNewsModel.fromJson(e)).toList();
          } else {
            throw Exception("Failed to fetch tab news: ${response.reasonPhrase}");
          }
        }
        for (var category in state.category) {
          int id = category.id;
          fetchTabNews(id).then((List<TabNewsModel> tabNewsList) {

            // Add category information
            tabViews.add(
                ListView.builder(
                  itemCount: tabNewsList.length,
                  itemBuilder: (context, index) {
                    var news = tabNewsList[index];
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width*0.7,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                      child: Row(
                        children: [
                          Image.network(news.photo_url,width: MediaQuery.of(context).size.width*0.2,height: 100,fit: BoxFit.fill,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.45,
                                child: Text(news.title, style: TextStyle(fontWeight: FontWeight.bold),  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,)),
                            Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: Text(news.description,  style: TextStyle(fontSize: 11), maxLines: 2,
                                  overflow: TextOverflow.ellipsis,)),
                          ],)
                          // Adjust the widget based on your TabNewsModel properties
                        ],
                      ),
                    );
                  },
                )
            );
          });
        }

        return Column(
          children: [
            SizedBox(
                height: 60,
                child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    tabs: tabs)),
            SizedBox(
              width: double.maxFinite,
              height: 1000,
              child: TabBarView(controller: _tabController, children: tabViews),
            )
          ],
        );
      }

      if (state is CategoryErrorState) {
        return Center(
          child: Text(state.error),
        );
      }

      return const Center(
        child: Text("Unknown State"),
      );
    });
  }
}
