import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/category/category_blocs.dart';
import 'package:interview/blocs/category/category_states.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryStates>(builder: (context, state) {
      if(state is CategoryLoadingState){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if(state is CategoryLoadedState){
        TabController _tabController = TabController(length: state.category.length, vsync: this);
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
        // Create TabBarView children based on API data
        tabViews = state.category.map((category) {
          return Center(
            child: Text("${category.name} and Id: ${category.id}"),
          );
        }).toList();

        void onTabTapped(int index) {
          int selectedCategoryId = state.category[index].id;
          print('Fetching data for category ID: $selectedCategoryId');
        }
        return Column(
          children: [
            SizedBox(
                height: 60,
                child: TabBar(
                  onTap: onTabTapped,
                  controller: _tabController,
                  isScrollable: true,
                  indicator: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  tabs: tabs
                )),
            SizedBox(
              width: double.maxFinite,
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: tabViews
              ),
            )
          ],
        );
      }

      if(state is CategoryErrorState){
        return Center(child: Text(state.error),);
      }

        return const Center(child: Text("Unknown State"),);

    });

  }
}
