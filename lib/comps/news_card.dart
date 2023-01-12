import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minews/services/fetch_data.dart';

class NewsCard extends StatelessWidget {
  final Map article;
  static var fetchData_obj = FetchData();
  final imageLoader = const SpinKitFadingCircle(
    color: Colors.black,
  );

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          article["networkImg"]
              ? Image.network(
                  article["urlToImage"],
                  fit: BoxFit.cover,
                  width: 300,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return imageLoader;
                    }
                  },
                )
              : Image.asset(
                  "lib/images/error_img.png",
                  fit: BoxFit.cover,
                  width: 100,
                ),
          const SizedBox(height: 5),
          Text(
            article["title"] != null ? article["title"] : "",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            article["author"] != null ? article["author"] : "Unknown",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            fetchData_obj.getDateTime(article["publishedAt"]),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       // title
    //       Text(
    //         fetchData_obj.top_headlines["articles"][index]["title"],
    //         style: const TextStyle(
    //           color: Colors.black,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 15,
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 5,
    //       ),

    //       gotBytes
    //           ? Image.network(
    //               fetchData_obj.top_headlines["articles"][index]["urlToImage"],
    //               fit: BoxFit.cover,
    //             )
    //           : !gotBytes && imgErrored
    //               ? Image.asset(
    //                   "../images/error_img.png",
    //                   fit: BoxFit.cover,
    //                 )
    //               : Center(
    //                   child: imageLoader,
    //                 ),
    //       const SizedBox(
    //         height: 5,
    //       ),

    //       // description
    //       Text(
    //           fetchData_obj.top_headlines["articles"][index]["description"] !=
    //                   null
    //               ? fetchData_obj.top_headlines["articles"][index]
    //                   ["description"]
    //               : "",
    //           style: TextStyle(
    //             color: Colors.grey.shade600,
    //             fontWeight: FontWeight.normal,
    //             fontSize: 13,
    //           )),
    //       const SizedBox(
    //         height: 5,
    //       ),

    //       // publisher and date
    //       Column(
    //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Row(
    //             children: [
    //               Icon(
    //                 Icons.watch_later_outlined,
    //                 size: 14,
    //                 color: Colors.grey.shade400,
    //               ),
    //               const SizedBox(
    //                 width: 3,
    //               ),
    //               Text(
    //                 fetchData_obj.getDateTime(fetchData_obj
    //                     .top_headlines["articles"][index]["publishedAt"]),
    //                 style: TextStyle(
    //                   fontSize: 11,
    //                   color: Colors.grey.shade400,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 5,
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.source_outlined,
    //                 size: 14,
    //                 color: Colors.grey.shade400,
    //               ),
    //               const SizedBox(
    //                 width: 5,
    //               ),
    //               Container(
    //                 width: 200,
    //                 child: Text(
    //                   fetchData_obj.top_headlines["articles"][index]
    //                           ["author"] ??
    //                       "Unknown",
    //                   style: TextStyle(
    //                     fontSize: 11,
    //                     color: Colors.grey.shade400,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 5,
    //       ),
    //       InkWell(
    //         onTap: () {
    //           // view the article in webview
    //           displayFullArticle(
    //               fetchData_obj.top_headlines["articles"][index]["url"]);
    //         },
    //         borderRadius: BorderRadius.circular(5),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               color: Colors.blue.shade300,
    //               borderRadius: BorderRadius.circular(5)),
    //           child: const Padding(
    //             padding: EdgeInsets.all(5.0),
    //             child: Text(
    //               "Read more",
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.normal,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 10,
    //       ),
    //       // Container(
    //       //   height: 1,
    //       //   decoration: BoxDecoration(
    //       //     color: primaryColor,
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
