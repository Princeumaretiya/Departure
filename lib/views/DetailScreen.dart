// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:math' as math;
// import '../controller/JsonProvider.dart';
// import '../controller/themeProvider.dart';
// import 'ShlockDetailScreen.dart';
//
// class DetailScreen extends StatefulWidget {
//   final index;
//
//   DetailScreen({super.key, this.index});
//
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//   @override
//   void initState() {
//     loadJsonData();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   loadJsonData() async {
//     var jsonprovider = Provider.of<JsonLoad>(context, listen: false);
//     setState(() {
//       jsonprovider.isLoading = true;
//     });
//     await jsonprovider.loadJsonAsset().then((value) {
//       setState(() {
//         jsonprovider.isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final lanProvider = Provider.of<ModelTheme>(context, listen: true);
//     var jsonProvider = Provider.of<JsonLoad>(context, listen: true);
//     return SafeArea(
//         child: Scaffold(
//             body: (jsonProvider.isLoading == true)
//                 ? Container(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   )
//                 : jsonProvider
//                             .jsonData![lanProvider.isLang][widget.index]
//                                 ["shlocks"]
//                             .length ==
//                         0
//                     ? Container(
//                         child: Center(
//                         child: Text("no_available_shlock"),
//                       ))
//                     : CustomScrollView(
//                         slivers: [
//                           SliverAppBar(
//                             backgroundColor: Color(
//                                     (math.Random().nextDouble() * 0xFFFFFF)
//                                         .toInt())
//                                 .withOpacity(0.3),
//                             title: Text(
//                               jsonProvider.jsonData![lanProvider.isLang]
//                                   [widget.index]["translation"],
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SliverToBoxAdapter(
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsets.all(10),
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Color((math.Random().nextDouble() *
//                                                 0xFFFFFF)
//                                             .toInt())
//                                         .withOpacity(0.4)),
//                                 child: Text(
//                                   jsonProvider.jsonData![lanProvider.isLang]
//                                       [widget.index]["summary"]["en"],
//                                   textAlign: TextAlign.justify,
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SliverList(
//                             delegate: SliverChildBuilderDelegate(
//                               (_, int index) {
//                                 return InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ShlockDetailScreen(
//                                                   details:
//                                                       jsonProvider.jsonData![
//                                                                   lanProvider
//                                                                       .isLang]
//                                                               [widget.index]
//                                                           ["slocks"][index],
//                                                 )));
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Color(
//                                                 (math.Random().nextDouble() *
//                                                         0xFFFFFF)
//                                                     .toInt())
//                                             .withOpacity(0.2),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                     child: Consumer<ModelTheme>(
//                                       builder: (context, themevalue, child) {
//                                         return ListTile(
//                                           leading: RichText(
//                                               text: TextSpan(children: [
//                                             TextSpan(
//                                                 text: "verb",
//                                                 style: TextStyle(
//                                                     color: themevalue.isDark
//                                                         ? Colors.black
//                                                         : Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 20)),
//                                             TextSpan(
//                                                 text:
//                                                     " ${jsonProvider.jsonData![lanProvider.isLang][widget.index]["slocks"][index]["shlok_no"]}",
//                                                 style: TextStyle(
//                                                     color: themevalue.isDark
//                                                         ? Colors.black
//                                                         : Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16))
//                                           ])),
//                                           trailing: Icon(
//                                             Icons.navigate_next,
//                                             size: 30,
//                                           ),
//                                           title: Center(
//                                             child: Text(
//                                               "${jsonProvider.jsonData![lanProvider.isLang][widget.index]["slocks"][index]["shlok_name"]}",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: themevalue.isDark
//                                                     ? Colors.black
//                                                     : Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               },
//                               childCount: jsonProvider
//                                   .jsonData![lanProvider.isLang][widget.index]
//                                       ["slocks"]
//                                   .length,
//                             ),
//                           )
//                         ],
//                       )));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../controller/JsonProvider.dart';

import '../controller/themeProvider.dart';
import 'ShlockDetailScreen.dart';

class DetailsPage extends StatefulWidget {
  final index;

  DetailsPage({super.key, this.index});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //print(jsonData);

  @override
  void initState() {
    loadJsonData();
    // TODO: implement initState
    super.initState();
  }

  loadJsonData() async {
    var jsonprovider = Provider.of<JsonLoad>(context, listen: false);
    setState(() {
      jsonprovider.isLoading = true;
    });
    await jsonprovider.loadJsonAsset().then((value) {
      setState(() {
        jsonprovider.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lanProvider = Provider.of<ModelTheme>(context, listen: true);
    var jsonProvider = Provider.of<JsonLoad>(context, listen: true);
    return SafeArea(
        child: Scaffold(
            body: (jsonProvider.isLoading == true)
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : jsonProvider
                            .jsonData![lanProvider.isLang][widget.index]
                                ["slocks"]
                            .length ==
                        0
                    ? Container(
                        child: Center(
                        child: Text("no_available_shlock"),
                      ))
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: Color(
                                    (math.Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                .withOpacity(0.3),
                            title: Text(
                              jsonProvider.jsonData![lanProvider.isLang]
                                  [widget.index]["translation"],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(0.4)),
                                child: Text(
                                  jsonProvider.jsonData![lanProvider.isLang]
                                      [widget.index]["summary"]["en"],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShlockDetailScreen(
                                                  details:
                                                      jsonProvider.jsonData![
                                                                  lanProvider
                                                                      .isLang]
                                                              [widget.index]
                                                          ["slocks"][index],
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Consumer<ModelTheme>(
                                      builder: (context, themevalue, child) {
                                        return ListTile(
                                          leading: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "verb",
                                                style: TextStyle(
                                                    color: themevalue.isDark
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            TextSpan(
                                                text:
                                                    " ${jsonProvider.jsonData![lanProvider.isLang][widget.index]["slocks"][index]["shlok_no"]}",
                                                style: TextStyle(
                                                    color: themevalue.isDark
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16))
                                          ])),
                                          trailing: Icon(
                                            Icons.arrow_right_sharp,
                                            size: 30,
                                          ),
                                          title: Center(
                                            child: Text(
                                              "${jsonProvider.jsonData![lanProvider.isLang][widget.index]["slocks"][index]["shlok_name"]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: themevalue.isDark
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              childCount: jsonProvider
                                  .jsonData![lanProvider.isLang][widget.index]
                                      ["slocks"]
                                  .length,
                            ),
                          )
                        ],
                      )));
  }
}
