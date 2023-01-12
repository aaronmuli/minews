import 'package:flutter/services.dart';
import 'package:minews/services/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchData {
  late Data data_obj;
  Map search_results = {};
  Map top_headlines = {};
  List<Map> topHeadlines = [];

  FetchData() {
    data_obj = Data();
  }

  String getDateTime(String dateTimeString) {
    DateTime date = DateTime.parse(dateTimeString);
    DateTime today = DateTime.now();

    if (today.day == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("today  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("today  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 1) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("today  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("today  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 2) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("yestarday  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("yestarday  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 3) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("3 days ago  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("3 days ago  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 4) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("4 days ago  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("4 days ago  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 5) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("5 days ago  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("5 days ago  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 6) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("6 days ago  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("6 days ago  ${date.hour}:${date.minute}");
      }
    } else if ((today.day - 7) == date.day &&
        today.month == date.month &&
        today.year == date.year) {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("a week ago  ${date.hour}:0${date.minute}");
        // break;
        default:
          return ("a week ago  ${date.hour}:${date.minute}");
      }
    } else {
      switch (date.minute) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
          return ("${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}");
        // break;
        default:
          return ("${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}");
      }
    }
  }

  void checkImage(Map article) async {
    try {
      var imgData = await http.get(Uri.parse(article["urlToImage"]));
      Uint8List img = imgData.bodyBytes;
      if (img.isNotEmpty) {
        article["networkImg"] = true;
      } else {
        article["networkImg"] = false;
      }
      topHeadlines.add(article);
    } catch (e) {
      print(e.toString());
    }
  }

  // get the full page
  // void getFullPage(String) {

  // }

  // fetch search data
  void fetchSearchNews(String query, hasSearch) async {
    // url = ('https://newsapi.org/v2/everything?'
    //    'q=messi&'
    // #    'from=2022-11-26&'
    //    'sortBy=date&'
    //    'apiKey=e932dfd2a8c0407f8f218c1ae2af5f91')
    const String apiKey = "e932dfd2a8c0407f8f218c1ae2af5f91";
    String sortBy = "date";
    Uri url = Uri.https("newsapi.org", "/v2/everything", {
      "q": query,
      "apiKey": apiKey,
      "language": data_obj.languageCode,
      "sortBy": "date"
    });
    // String full_url =
    //     "https://newsapi.org/v2/everything?q=$query&sortBy=date&apiKey=$apiKey";
    // Uri url_1 = Uri.parse(full_url);

    try {
      var response = await http.get(url);
      search_results = jsonDecode(response.body);
      hasSearch(true);
    } catch (e) {
      if (e == FormatException) {
        return;
      } else {
        print(e.toString());
      }
    }
  }

  // fetch top headlines
  fetchTopHeadlines({category}) async {
    // category
    // language
    // // source
    // const String authority = "newsapi.org";
    // const String unEncodedPath = "/v2/top-headlines";
    const String apiKey = "e932dfd2a8c0407f8f218c1ae2af5f91";

    if (category != "all") {
      Uri url_1 = Uri(
          scheme: 'https',
          host: 'newsapi.org',
          path: '/v2/top-headlines',
          queryParameters: {
            'apiKey': apiKey,
            'language': 'en',
            'category': category
          });
      try {
        top_headlines.clear();
        topHeadlines.clear();

        var response = await http.get(url_1);
        top_headlines = jsonDecode(response.body);
        for (Map article in top_headlines["articles"]) {
          var imgData = await http.get(Uri.parse(article["urlToImage"]));
          Uint8List img = imgData.bodyBytes;
          if (img.isNotEmpty) {
            article["networkImg"] = true;
          } else {
            article["networkImg"] = false;
          }
          topHeadlines.add(article);
        }
      } catch (e) {
        if (e == FormatException) {
          return;
        } else {
          print("error in categories fetch");
          print(e.toString());
        }
      }
    } else {
      Uri url_1 = Uri(
          scheme: 'https',
          host: 'newsapi.org',
          path: '/v2/top-headlines',
          queryParameters: {
            'apiKey': apiKey,
            'language': 'en',
          });

      try {
        top_headlines.clear();
        topHeadlines.clear();

        var response = await http.get(url_1);
        top_headlines = jsonDecode(response.body);
        for (Map article in top_headlines["articles"]) {
          var imgData = await http.get(Uri.parse(article["urlToImage"]));
          Uint8List img = imgData.bodyBytes;
          if (img.isNotEmpty) {
            article["networkImg"] = true;
          } else {
            article["networkImg"] = false;
          }
          topHeadlines.add(article);
        }
      } catch (e) {
        if (e == FormatException) {
          return;
        } else {
          print("fetchTopHeadlines 2 ${e.toString()}");
        }
      }
    }
  }
// # top headlines

// # different urls

// # to get top headlines on trump
// # GET https://newsapi.org/v2/top-headlines?q=trump&apiKey=e932dfd2a8c0407f8f218c1ae2af5f91

// # to get business top headlines from germany
// # GET https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=e932dfd2a8c0407f8f218c1ae2af5f91

// # top headlines from bbc
// # GET https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=e932dfd2a8c0407f8f218c1ae2af5f91

// # to get top headlines in the us
// # GET https://newsapi.org/v2/top-headlines?country=us&apiKey=e932dfd2a8c0407f8f218c1ae2af5f91

// url = ('https://newsapi.org/v2/top-headlines?'
//         # 'sources=bbc-news&'
//         #'country=zm&'
//         'language=en&'
//         # 'category=sports&'
//         'apiKey=e932dfd2a8c0407f8f218c1ae2af5f91')
// # response = requests.get(url)
// # print(response.json())

// res = {
//     'status': 'ok',
//     'totalResults': 1000,
//     'articles': [
//         {
//             'source': {
//             'id': None,
//             'name': 'As.com'
//         },

  // Map top_headlines = {
  //   'status': 'ok',
  //   'totalResults': 1,
  //   'articles': [
  //     {
  //       'networkImg': false,
  //       'source': {'id': null, 'name': 'As.com'},
  //       'author': 'As.com',
  //       'title':
  //           'Mundial Qatar 2022 en directo: última hora de la Copa del Mundo, noticias y resultados, hoy en vivo - AS ',
  //       'description':
  //           'Sigue la última hora del Mundial de Qatar 2022. Bajas de última hora, noticias y todo relacionado con la cita mundialista, hoy 26 de noviembre.',
  //       'url':
  //           'https://as.com/futbol/mundial/mundial-qatar-2022-en-directo-ultima-hora-de-la-copa-del-mundo-noticias-y-resultados-hoy-en-vivo-n-5/',
  //       'urlToImage':
  //           'https://img.asmedia.epimg.net/resizer/zLbAJyAGjxmYJVPLB-vd1vkHv5s=/644x362/filters:focal(306x266:316x276)/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/ICK5E6MBEFXDXL3B7A64DF57CY.jpg',
  //       'publishedAt': '2022-11-26T08:37:32Z',
  //       'content':
  //           'Primer turno del día\r\nEl primer encuentro que se disputará en la jornada de hoy, 26 de noviembre, será el Túnez - Australia, a las 11:00 horas. Partido correspondiente a la jornada 2 del grupo D.\r\nSi… [+156 chars]'
  //     },
  //     {
  //       'networkImg': true,
  //       "source": {"id": "bbc-news", "name": "BBC News"},
  //       "author": null,
  //       "title": "James returns as Lakers beat struggling Spurs",
  //       "description":
  //           "LeBron James helps the Los Angeles Lakers claim their first away win of the season on his return from a five-game injury lay-off.",
  //       "url": "https://www.bbc.co.uk/sport/basketball/63766296",
  //       "urlToImage":
  //           "https://ichef.bbci.co.uk/live-experience/cps/624/cpsprodpb/F1C0/production/_127788816_hi080590414.jpg",
  //       "publishedAt": "2022-11-26T08:08:43Z",
  //       "content":
  //           "LeBron James (centre) has won four NBA championships\r\nLeBron James helped the Los Angeles Lakers beat the San Antonio Spurs 105-94 on his return from a five-game injury lay-off.\r\nJames, sidelined by … [+911 chars]"
  //     },
  //     {
  //       'networkImg': true,
  //       "source": {"id": null, "name": "ESPN"},
  //       "author": "Dave McMenamin",
  //       "title": "LeBron available for Lakers after 5-game absence",
  //       "description":
  //           "Lakers star LdarkTheme: ,eBron James is available to play Friday night at San Antonio after missing five games because of a left groin strain.",
  //       "url":
  //           "https://www.espn.com/nba/story/_/id/35108658/lebron-james-returns-lakers-spurs-5-game-absence",
  //       "urlToImage":
  //           "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2022%2F1126%2Fr1096962_1296x729_16%2D9.jpg",
  //       "publishedAt": "2022-11-26T00:15:26Z",
  //       "content":
  //           "SAN ANTONIO -- Los Angeles Lakers star LeBron James is available to play Friday night against the San Antonio Spurs following a five-game absence because of a left groin strain, the team announced.\r\n… [+522 chars]"
  //     },
  //     {
  //       'networkImg': false,
  //       "source": {"id": null, "name": "Gazzetta.it"},
  //       "author": "Riccardo Pratesi",
  //       "title":
  //           "Giannis show, i Bucks travolgono Cleveland. Banchero (19 punti) non salva i Magic",
  //       "description":
  //           "Giannis show, i Bucks travolgono Cleveland. Banchero (19 punti) non salva i MagicOrlando cade con Philadelphia. Rientra LeBron e i Lakers tornano a vincere. Boston sul velluto, successi per Warriors, Grizzlies e Suns. Houston ferma Atlanta",
  //       "url":
  //           "https://www.gazzetta.it/Nba/26-11-2022/nba-risultati-milwaukee-cleveland-orlando-philadelphia-boston-sacramento-4501278142459.shtml",
  //       "urlToImage":
  //           "https://images2.gazzettaobjects.it/methode_image/2022/11/26/Varie/Foto_Varie_-_Trattate/12f247112d3927bde9ce3fd0a80b2b23_1200x675.jpg?v=202211260744",
  //       "publishedAt": "2022-11-26T06:43:57Z",
  //       "content":
  //           "Riccardo Pratesi\r\n &amp;commat;rprat75\r\n26 novembre\r\n - Milano\r\n Notte di conferme e di ritorni, in Nba. C’erano 14 partite in programma: Milwaukee e Boston si confermano le corazzate dell’Est, Banch… [+9504 chars]"
  //     }
  //   ]
  // };

  // Map search_results = {
  //   'status': 'ok',
  //   'totalResults': 1,
  //   'articles': [
  //     {
  //       'source': {'id': null, 'name': 'As.com'},
  //       'author': 'As.com',
  //       'title':
  //           'Mundial Qatar 2022 en directo: última hora de la Copa del Mundo, noticias y resultados, hoy en vivo - AS ',
  //       'description':
  //           'Sigue la última hora del Mundial de Qatar 2022. Bajas de última hora, noticias y todo relacionado con la cita mundialista, hoy 26 de noviembre.',
  //       'url':
  //           'https://as.com/futbol/mundial/mundial-qatar-2022-en-directo-ultima-hora-de-la-copa-del-mundo-noticias-y-resultados-hoy-en-vivo-n-5/',
  //       'urlToImage':
  //           'https://img.asmedia.epimg.net/resizer/zLbAJyAGjxmYJVPLB-vd1vkHv5s=/644x362/filters:focal(306x266:316x276)/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/ICK5E6MBEFXDXL3B7A64DF57CY.jpg',
  //       'publishedAt': '2022-11-26T08:37:32Z',
  //       'content':
  //           'Primer turno del día\r\nEl primer encuentro que se disputará en la jornada de hoy, 26 de noviembre, será el Túnez - Australia, a las 11:00 horas. Partido correspondiente a la jornada 2 del grupo D.\r\nSi… [+156 chars]'
  //     },
  //     {
  //       "source": {"id": "bbc-news", "name": "BBC News"},
  //       "author": null,
  //       "title": "James returns as Lakers beat struggling Spurs",
  //       "description":
  //           "LeBron James helps the Los Angeles Lakers claim their first away win of the season on his return from a five-game injury lay-off.",
  //       "url": "https://www.bbc.co.uk/sport/basketball/63766296",
  //       "urlToImage":
  //           "https://ichef.bbci.co.uk/live-experience/cps/624/cpsprodpb/F1C0/production/_127788816_hi080590414.jpg",
  //       "publishedAt": "2022-11-26T08:08:43Z",
  //       "content":
  //           "LeBron James (centre) has won four NBA championships\r\nLeBron James helped the Los Angeles Lakers beat the San Antonio Spurs 105-94 on his return from a five-game injury lay-off.\r\nJames, sidelined by … [+911 chars]"
  //     },
  //     {
  //       "source": {"id": null, "name": "ESPN"},
  //       "author": "Dave McMenamin",
  //       "title": "LeBron available for Lakers after 5-game absence",
  //       "description":
  //           "Lakers star LdarkTheme: ,eBron James is available to play Friday night at San Antonio after missing five games because of a left groin strain.",
  //       "url":
  //           "https://www.espn.com/nba/story/_/id/35108658/lebron-james-returns-lakers-spurs-5-game-absence",
  //       "urlToImage":
  //           "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2022%2F1126%2Fr1096962_1296x729_16%2D9.jpg",
  //       "publishedAt": "2022-11-26T00:15:26Z",
  //       "content":
  //           "SAN ANTONIO -- Los Angeles Lakers star LeBron James is available to play Friday night against the San Antonio Spurs following a five-game absence because of a left groin strain, the team announced.\r\n… [+522 chars]"
  //     },
  //     {
  //       "source": {"id": null, "name": "Gazzetta.it"},
  //       "author": "Riccardo Pratesi",
  //       "title":
  //           "Giannis show, i Bucks travolgono Cleveland. Banchero (19 punti) non salva i Magic",
  //       "description":
  //           "Giannis show, i Bucks travolgono Cleveland. Banchero (19 punti) non salva i MagicOrlando cade con Philadelphia. Rientra LeBron e i Lakers tornano a vincere. Boston sul velluto, successi per Warriors, Grizzlies e Suns. Houston ferma Atlanta",
  //       "url":
  //           "https://www.gazzetta.it/Nba/26-11-2022/nba-risultati-milwaukee-cleveland-orlando-philadelphia-boston-sacramento-4501278142459.shtml",
  //       "urlToImage":
  //           "https://images2.gazzettaobjects.it/methode_image/2022/11/26/Varie/Foto_Varie_-_Trattate/12f247112d3927bde9ce3fd0a80b2b23_1200x675.jpg?v=202211260744",
  //       "publishedAt": "2022-11-26T06:43:57Z",
  //       "content":
  //           "Riccardo Pratesi\r\n &amp;commat;rprat75\r\n26 novembre\r\n - Milano\r\n Notte di conferme e di ritorni, in Nba. C’erano 14 partite in programma: Milwaukee e Boston si confermano le corazzate dell’Est, Banch… [+9504 chars]"
  //     }
  //   ]
  // };

//         'author': 'As.com',
//         'title': 'Mundial Qatar 2022 en directo: última hora de la Copa del Mundo, noticias y resultados, hoy en vivo - AS ',
//         'description': 'Sigue la última hora del Mundial de Qatar 2022. Bajas de última hora, noticias y todo relacionado con la cita mundialista, hoy 26 de noviembre.',
//         'url': 'https://as.com/futbol/mundial/mundial-qatar-2022-en-directo-ultima-hora-de-la-copa-del-mundo-noticias-y-resultados-hoy-en-vivo-n-5/',
//         'urlToImage': 'https://img.asmedia.epimg.net/resizer/zLbAJyAGjxmYJVPLB-vd1vkHv5s=/644x362/filters:focal(306x266:316x276)/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/ICK5E6MBEFXDXL3B7A64DF57CY.jpg',
//         'publishedAt': '2022-11-26T08:37:32Z',
//         'content': 'Primer turno del día\r\nEl primer encuentro que se disputará en la jornada de hoy, 26 de noviembre, será el Túnez - Australia, a las 11:00 horas. Partido correspondiente a la jornada 2 del grupo D.\r\nSi… [+156 chars]'},
//          {'source': {'id': None, 'name': 'YouTube'}, 'author': None, 'title': 'QATAR 2022 | ESPAÑA | ENTREVISTA a DANI OLMO: "No nos la queremos jugar contra JAPÓN" | Diario AS - Diario AS', 'description': 'Dani Olmo (Terrassa, 1998) es, a pesar de su juventud, uno de los veteranos de esta España. El catalán interpreta el juego de Luis Enrique como casi nadie.No...', 'url': 'https://www.youtube.com/watch?v=guMAxn50BYs', 'urlToImage': 'https://i.ytimg.com/vi/guMAxn50BYs/hqdefault.jpg', 'publishedAt': '2022-11-26T08:28:00Z', 'content': None}, {'source': {'id': 'bild', 'name': 'Bild'}, 'author': 'CHRISTIAN FALK, TOBIAS ALTSCHÄFFL, HEIKO NIEDDERER, YVONNE GABRIEL, YANNICK HÜBER, LARS GARTENSCHLÄGER, JULIEN WOLFF, TORSTEN RUMPF, MATTHIAS MARBURG, JÖRG ALTHOFF, JENS BIERSCHWALE, KAI FELDHAUS, DENNIS BROSDA UND CHRISTIAN SPREITZ', 'title': 'WM 2022: Worum es geht... – DFB riskiert Fifa-Geldstrafe - BILD', 'description': 'Trubel vor unserem WM-Endspiel! Der DFB könnte eine Geldstrafe riskieren.', 'url': 'https://www.bild.de/sport/fussball/nationalmannschaft/wm-2022-worum-es-geht-dfb-riskiert-fifa-geldstrafe-82065126.bild.html', 'urlToImage': 'https://images.bild.de/6381173808ba5f71743a9750/33693f02f61e21eca3281fab763b3e3c,9a140618?w=1280', 'publishedAt': '2022-11-26T08:24:36Z', 'content': 'Strafen-Trubel vor unserem WM-Endspiel...\r\nAm Sonntag könnte das Turnier in Katar für die DFB-Elf schon gelaufen sein. Bei einer Niederlage gegen Spanien wäre die Nationalmannschaft nach dem zweiten … [+1337 chars]'}]}

}
