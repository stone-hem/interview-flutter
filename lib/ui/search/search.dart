import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:interview/common/constants.dart';
import 'package:interview/models/TabNewsModel.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                      _doSearch(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      filled: true,
                      // Fill the background
                      fillColor: Colors.white,
                      // Set gray background color
                      border: const OutlineInputBorder(),
                      // Add border
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        // Set border color on focus
                        borderRadius: BorderRadius.circular(8), // Optional: Set border radius
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                FutureBuilder<List<TabNewsModel>>(
                  future: _doSearch(search),
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
                        shrinkWrap: true,
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newsItem.created_at,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<TabNewsModel>> _doSearch(String search) async {

    Response response = await get(Uri.parse("$baseUrl/search/$search"));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => TabNewsModel.fromJson(e)).toList();
    } else {
      throw Exception(response.body);
    }
  }
}
