import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:interview/blocs/category/category_blocs.dart';
import 'package:interview/blocs/category/category_states.dart';
import 'package:interview/models/CategoryModel.dart';
import 'package:interview/models/NewsModel.dart';
import 'package:interview/models/TabNewsModel.dart';
import 'package:interview/models/TabNewsModel.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
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
                        onTap: (index) {
                          print(index);
                        },
                        isScrollable: true,
                        tabs: categoryList.map((category) {
                          return Tab(
                            text: category
                                .name, // Assuming 'name' is a property in your CategoryModel
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: double.maxFinite,
                      child: TabBarView(
                        controller: _tabController,
                        children: categoryList.map((category) {
                          return _lists(
                              category.id); // Pass category to your _lists function
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
              return ListTile(
                title: Text(newsItem.title ?? ''),
                subtitle: Text(newsItem.description ?? ''),
                // ... other UI elements for the news item
              );
            },
          );
        }
      },
    );
  }


  Widget _listse(id) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1706200234277-3586cd003ba3?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "$id",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "date",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: const Text(
                          "This is just the normal text to be pu here This is just the normal text to be pu here This is just the normal text to be pu here",
                          maxLines: 3,
                          textAlign: TextAlign.left)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<List<TabNewsModel>> _getTab(int categoryId) async{
    Response response=await get(Uri.parse("http://192.168.88.236:8000/api/categories/$categoryId"));
    if(response.statusCode==200){
      final List result=jsonDecode(response.body);
      return result.map((e) => TabNewsModel.fromJson(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}
