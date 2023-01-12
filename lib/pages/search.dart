import 'package:flutter/material.dart';
import 'package:minews/services/data.dart';
import 'package:minews/services/fetch_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Data data_obj = Data();
  FetchData fetchData_obj = FetchData();

  String search_query = "";
  bool hasSearchResults = false;
  bool imageAvailable = false;
  bool searching = false;
  int current_category = 0;

  final imageLoader = const SpinKitFadingCircle(
    color: Colors.black,
  );

  final searchLoader = const SpinKitPouringHourGlass(
    color: Colors.grey,
    size: 80,
  );

  void hasSearch(bool value) {
    setState(() {
      hasSearchResults = value;
      searching = false;
    });
  }

  void checkImageAvailability(String imageUrl) async {
    try {
      final res = await http.get(Uri.parse(imageUrl));
      if (res.bodyBytes.isNotEmpty) {
        setState(() {
          imageAvailable = true;
        });
      } else {
        setState(() {
          imageAvailable = false;
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Discover",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "News from all over the world",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              cursorColor: Colors.black45,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (val) {
                search_query = val;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(10)),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  splashRadius: 20,
                  splashColor: Colors.blue,
                  onPressed: () {
                    setState(() {
                      searching = true;
                      hasSearchResults = false;
                    });
                    fetchData_obj.fetchSearchNews(search_query, hasSearch);
                    // print(
                    // "${data_obj.languageCode}, ${data_obj.sortbyList[data_obj.sortValue]}, ${data_obj.category}");
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "search",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //the search results here
            hasSearchResults
                ? Expanded(
                    child: ListView.builder(
                        itemCount:
                            fetchData_obj.search_results["articles"].length,
                        itemBuilder: (BuildContext context, int index) {
                          // dynamic imageUrl;
                          // if (fetchData_obj.search_results["articles"][index]
                          //         ["urlToImage"] !=
                          //     null) {
                          //   checkImageAvailability(
                          //       fetchData_obj.search_results["articles"][index]
                          //           ["urlToImage"]);
                          //   if (imageAvailable) {
                          //     imageUrl =
                          //         fetchData_obj.search_results["articles"]
                          //             [index]["urlToImage"];
                          //   } else if (!imageAvailable) {
                          //     imageUrl = null;
                          //   }
                          // }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(10),
                                //   child: Image.asset(
                                //     "lib/images/qatar-2022.jpg",
                                //     fit: BoxFit.cover,
                                //     scale: 8,
                                //     // width: 90.0,
                                //     // height: 90.0,
                                //   ),
                                // ),

                                fetchData_obj.search_results["articles"][index]
                                            ["urlToImage"] ==
                                        null
                                    ? const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: 120,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          fetchData_obj
                                                  .search_results["articles"]
                                              [index]["urlToImage"],
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(child: imageLoader);
                                            }
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                    size: 120,
                                                  ),
                                                  Text(
                                                    "Image error",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                  // height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    print(
                                        "display webview widget for ${fetchData_obj.search_results["articles"][index]["url"]}");
                                  },
                                  child: Text(
                                    fetchData_obj.search_results["articles"]
                                        [index]["title"],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 14,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      fetchData_obj.getDateTime(fetchData_obj
                                              .search_results["articles"][index]
                                          ["publishedAt"]),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.source_outlined,
                                      size: 14,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        fetchData_obj.search_results["articles"]
                                                [index]["author"] ??
                                            "Unknown",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }))
                : searching && !hasSearchResults
                    ? Expanded(child: Center(child: searchLoader))
                    : Expanded(child: Center()),
          ],
        ),
      ),
    );
  }
}
