import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/JsonProvider.dart';
import '../controller/themeProvider.dart';
import 'dart:math' as math;
import '../util/json.dart';
import 'DetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<JsonLoad>(context, listen: false).loadJsonAsset().then((value) {
      setState(() {
        isLoading = false;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  loadJsonData() async {
    final jsonprovider = Provider.of<JsonLoad>(context, listen: false);
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
    int Random = math.Random.secure().nextInt(300) + 1;

    final jsonprovider = Provider.of<JsonLoad>(context, listen: true);
    final lanProvider = Provider.of<ModelTheme>(context, listen: true);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Bhagavat Geeta",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.account_circle,
            size: 28,
           // color: Colors.white,
          )
        ],
        //centerTitle: true,
        backgroundColor: Colors.brown[900],
      ),
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            bottomSheet: Material(
              color: Colors.brown[900],
              child: TabBar(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home,
                      ),
                      text: "Home",
                    ),
                    Tab(
                      icon: Icon(Icons.bookmark),
                      text: "Bookmarked Verses",
                    ),
                  ]),
            ),
            body: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNMxXFnb8AdzJZcLfPMa4GcuvsjvHffrIn2g&usqp=CAU",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: TabBarView(
                children: [
                  NestedScrollView(
                    body: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://wallpaperaccess.com/full/2796591.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Chapters',
                                    textScaleFactor: 2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.toc_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                ],
                              )),
                        ),
                        (isLoading == true)
                            ? SliverToBoxAdapter(
                                child: Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.brown[900],
                                    ),
                                  ),
                                ),
                              )
                            : (jsonprovider.jsonData == null)
                                ? SliverToBoxAdapter(
                                    child: Center(
                                      child: Text("Not available!!"),
                                    ),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (_, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsPage(
                                                          index: index,
                                                        )));
                                          },
                                          child: ListTile(
                                            title: Text(
                                              jsonprovider.jsonData![
                                                      lanProvider.isLang][index]
                                                  ['translation'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            subtitle: Consumer<ModelTheme>(
                                              builder: (context, value, child) {
                                                return RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "🧾 ${jsonprovider.jsonData![lanProvider.isLang][index]['verses_count']} ",
                                                        style: TextStyle(
                                                            color: value.isDark
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: "verb",
                                                        style: TextStyle(
                                                            color: value.isDark
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ]),
                                                );
                                              },
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_right_sharp,
                                              color: Colors.brown[900],
                                            ),
                                            leading: Container(
                                              height: 20,
                                              width: 25,
                                              child: Center(
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "https://wallpaperaccess.com/full/2796591.jpg",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: jsonprovider
                                          .jsonData![lanProvider.isLang].length,
                                    ),
                                  )
                      ],
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          actions: [
                            Consumer<ModelTheme>(
                              builder: (context, themeNotifier, child) {
                                return GestureDetector(
                                  child: Icon(
                                    Icons.radio_button_checked,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    themeNotifier.isDark
                                        ? themeNotifier.isDark = false
                                        : themeNotifier.isDark = true;
                                  },
                                );
                              },
                            ),
                            Consumer<ModelTheme>(
                              builder: (context, value, child) {
                                return PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () async {
                                        value.Lang = "gujrati";
                                        print(value.isLang);
                                        newLocale = Locale('en', 'US');
                                        print("newLocal $newLocale");

                                        await EasyLocalization.of(context)
                                            ?.setLocale(newLocale);
                                      },
                                      value: 1,
                                      child: Text(
                                        "English",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () async {
                                        value.Lang = "english";
                                        print(value.isLang);
                                        newLocale = Locale('gu', 'IN');
                                        print(" first newLocal $newLocale");
                                        await EasyLocalization.of(context)
                                            ?.setLocale(newLocale);
                                      },
                                      value: 2,
                                      child: Text(
                                        "Gujrati",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                  elevation: 4,
                                );
                              },
                            ),
                          ],
                          automaticallyImplyLeading: false,
                          expandedHeight: 250.0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Image(
                              image: NetworkImage(
                                  "https://t4.ftcdn.net/jpg/04/83/67/61/360_F_483676144_8XDkDIhdzlCkwrMGKquArnzrTgJRixh3.jpg"),
                              fit: BoxFit.cover,
                              opacity: AlwaysStoppedAnimation(5.5),
                            ),
                          ),
                        )
                      ];
                    },
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            TextSpan(
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w500)),
                          ]),
                        ),
                      ),
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.4)),
                ],
              ),
            ),
          )),
    ));
  }
}

// List imagesList = [
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgMkGtJ1nS9EhiXhQdRWusK_Rad1s5YXv8Hg&usqp=CAU",
//   "https://daex9l847wg3n.cloudfront.net/shemoutputimages/Bhagavad-Gita/5b8d1d18a609d26f2a000021/large_16_9_1638877977.jpg",
//   "https://static.sadhguru.org/d/46272/1633189170-1633189168727.jpg",
//   "https://vedicfeed.com/wp-content/uploads/2019/02/Bhagavad-Gita-quotes.jpg",
//   "https://iskcondwarka.org/wp-content/uploads/2022/06/geeta-1482496566.jpg",
//   "https://shayari.himanchalll.com/wp-content/uploads/2020/10/1-1024x576.jpg",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-MQ-r7VTMolv8Ftz9iVbKFumHo0thoVJanw&usqp=CAU",
// ];
