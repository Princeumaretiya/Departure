import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreemad_bhagavat_geeta/views/SplashScreen.dart';
import 'controller/JsonProvider.dart';
import 'controller/themeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      saveLocale: true,
      fallbackLocale: Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ModelTheme>(
            create: (context) => ModelTheme(),
          ),
          ChangeNotifierProvider<JsonLoad>(
            create: (context) => JsonLoad(),
          ),
        ],
        child: Consumer<ModelTheme>(
          builder: (context, themeNotifier, child) {
            return MaterialApp(
              supportedLocales: EasyLocalization.of(context)!.supportedLocales,
              localizationsDelegates: EasyLocalization.of(context)!.delegates,
              locale: EasyLocalization.of(context)!.locale,
              theme: themeNotifier.isDark
                  ? ThemeData.light(useMaterial3: true)
                  : ThemeData.dark(useMaterial3: true),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          },
        ),
      ),
      supportedLocales: [Locale('en', 'US'), Locale('gu', 'IN')],
      path: 'asset/Translations'));
}
