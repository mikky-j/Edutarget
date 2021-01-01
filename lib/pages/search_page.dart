import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
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
