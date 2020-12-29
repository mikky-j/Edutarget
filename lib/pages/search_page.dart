import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String initialText;
  const SearchPage({
    Key key,
    this.initialText,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Text(
              "Search",
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blueGrey[100].withOpacity(0.3),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                  IconButton(icon: Icon(Icons.search), onPressed: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
