import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:interview/blocs/category/category_blocs.dart';
import 'package:interview/blocs/category/category_states.dart';
import 'package:interview/common/constants.dart';
import 'package:interview/models/CategoryModel.dart';
import 'package:interview/models/TabNewsModel.dart';
import 'package:interview/ui/search/search.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late String search = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Search())),
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
                      offset: const Offset(0, 3), // changes position of shadow
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
            BlocBuilder<CategoryBloc, CategoryStates>(
                builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const Center(
                  child: Text('Loading ...'),
                );
              }
              if (state is CategoryLoadedState) {
                List<CategoryModel> categoryList = state.category;
                TabController _tabController =
                    TabController(length: categoryList.length, vsync: this);
                return Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabs: categoryList.map((category) {
                          return Tab(
                            text: category
                                .name,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: double.maxFinite,
                      child: TabBarView(
                        controller: _tabController,
                        children: categoryList.map((category) {
                          return _lists(category
                              .id);
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }

  Widget _lists(int categoryId) {
    return FutureBuilder<List<TabNewsModel>>(
      future: _getTab(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No news data available.'),
          );
        } else {
          List<TabNewsModel> newsList = snapshot.data!;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              TabNewsModel newsItem = newsList[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "$imageUrl/${newsItem.photo_url}"),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsItem.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          newsItem.created_at,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(newsItem.description,
                              maxLines: 3, textAlign: TextAlign.left),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<TabNewsModel>> _getTab(int categoryId) async {
    Response response = await get(
        Uri.parse("$baseUrl/categories/$categoryId"));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => TabNewsModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
