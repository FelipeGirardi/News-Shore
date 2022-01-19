import 'package:flutter/material.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);
  static const routeName = '/search-news';

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  String searchText = '';
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                cursorColor: Colors.black,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                controller: _textController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        searchText = '';
                        _textController.clear();
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
                onSubmitted: (text) {
                  searchText = text;
                },
              ),
            ),
          )),
    );
  }
}
