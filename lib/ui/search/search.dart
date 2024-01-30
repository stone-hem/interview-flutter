import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      filled: true, // Fill the background
                      fillColor: Colors.white, // Set gray background color
                      border: const OutlineInputBorder(), // Add border
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue), // Set border color on focus
                        borderRadius: BorderRadius.circular(8), // Optional: Set border radius
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
