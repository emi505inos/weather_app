import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = 'Buenos Aires';
  String country = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(width: MediaQuery.of(context).size.width*0.05),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.70,
            height: MediaQuery.of(context).size.height*0.25,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a location',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                  fontSize: 18,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withAlpha(120),
                    width: 2.5
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withAlpha(120),
                    width: 2.5
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary.withAlpha(40),
              ),
            ),
          ),
          Spacer()
        ],
      ),
      body: Column(
        children: [
          
          
        ],
      )
    );
  }
}