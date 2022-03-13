import 'package:news_app_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'single_news_screen.dart';
import 'package:news_app_flutter/cryptonew-apiservice/cryptonews.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  List crypto_news = [];

  _fetchCryptoNews() async {
    var response = await CryptoNewsApiService().getCryptoNews();
    setState(() {
      crypto_news = json.decode(response.body);
      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    EasyLoading.show(status: 'Fetching Crypto News...');
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _fetchCryptoNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.all(24),
        children: <Widget>[
          Container(
            child: FxText.sh2("Good morning",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
                xMuted: true),
          ),
          Container(
            child: FxText.h4("Israa",
                color: theme.colorScheme.onBackground, fontWeight: 600),
          ),
          Container(
            margin: FxSpacing.top(24),
            child: FxText.b2("Your daily read crypto dose ",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
                muted: true),
          ),
          if (crypto_news.length > 0) ...[
            for (int i = 1; i <= 5; i++)
              _singleNews(
                  image: './assets/images/all/all-${i}.jpg',
                  source: crypto_news[i]['source'],
                  date: "Jan 10, 2021",
                  headline: crypto_news[i]['title'],
                  url: crypto_news[i]['url'],
                  timeToRead: "5 min read"),
          ] else
            ...[]
        ],
      )),
    );
  }

  _singleNews(
      {required String source,
      required String headline,
      required String image,
      required String url,
      required String date,
      required String timeToRead}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNewsScreen(url: url)));
      },
      child: Container(
        margin: FxSpacing.top(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  FxText.b1(headline,
                      color: theme.colorScheme.onBackground, fontWeight: 600),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: FxText.b2(date,
                              color: theme.colorScheme.onBackground,
                              fontSize: 11,
                              xMuted: true)),
                      Container(
                        decoration: BoxDecoration(
                            color:
                                theme.colorScheme.onBackground.withAlpha(100),
                            shape: BoxShape.circle),
                        width: 4,
                        height: 4,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: FxText.b2(timeToRead,
                              color: theme.colorScheme.onBackground,
                              xMuted: true)),
                      SizedBox(
                        width: 11,
                      ),
                      Icon(
                        MdiIcons.bookmark,
                        color: theme.colorScheme.primary,
                        size: 16,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
