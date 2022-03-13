import 'news_editor_profile_screen.dart';
import 'package:news_app_flutter/theme/app_theme.dart';
import 'package:news_app_flutter/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class SingleNewsScreen extends StatefulWidget {
  const SingleNewsScreen({Key? key, required this.url}) : super(key: key);
  final url;

  @override
  _SingleNewsScreenState createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
    );
  }
}
