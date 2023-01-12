// ignore_for_file: non_constant_identifier_names
// import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minews/comps/categories.dart';
import 'package:minews/comps/news_card.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:http/http.dart' as http;
import 'dart:io';

// import 'package:minews/pages/full_article.dart';
import 'package:minews/pages/search.dart';
import 'package:minews/pages/settings.dart';
import 'package:minews/services/data.dart';
import 'package:minews/services/fetch_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Data data_obj = Data();
  Search search_obj = const Search();
  Settings settings_obj = const Settings();
  FetchData fetchData_obj = FetchData();
  String search_query = "";

  bool gotHeadlines = false;
  bool imgErrored = false;

  final mainLoadingScreen = const SpinKitSpinningLines(
    color: Colors.grey,
    size: 100,
  );

  displayFullArticle(String url) {
    print("webview");
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => FullArticle(
    //               url: url,
    //             )));
  }

  getHeadlines(String category) async {
    setState(() {
      gotHeadlines = false;
    });
    await fetchData_obj.fetchTopHeadlines(category: category);
    if (fetchData_obj.top_headlines.isNotEmpty) {
      setState(() {
        gotHeadlines = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHeadlines(data_obj.category);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return gotHeadlines
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Headlines",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            getHeadlines(data_obj.category);
                          },
                          child: const Icon(Icons.refresh))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "From around the whole world.",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // categories container
                Categories(getHeadlines: getHeadlines),
                const SizedBox(
                  height: 15,
                ),

                // news articles
                Expanded(
                  child: ListView.builder(
                      itemCount: fetchData_obj.topHeadlines.length,
                      itemBuilder: (BuildContext context, index) {
                        // _getImageBytes(fetchData_obj.top_headlines["articles"]
                        //     [index]["urlToImage"]);
                        return NewsCard(
                            article: fetchData_obj.topHeadlines[index]);
                      }),
                )
              ],
            ))
        : Center(child: mainLoadingScreen);
  }
}
