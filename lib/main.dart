import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';
import 'package:mobile/utils/themes/constant.dart';
import 'package:mobile/utils/themes/service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile/youtube_player.dart';
import 'package:override_text_scale_factor/override_text_scale_factor.dart';
import 'package:upgrader/upgrader.dart';

import 'modules/startup/views/splash_screen_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        /* DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight, */
      ],
    );
    runApp(const IssiMobile());
  }, (dynamic error, dynamic stack) {
    //print(error);
    //print(stack);
  });
}

class IssiMobile extends StatefulWidget {
  const IssiMobile({Key? key}) : super(key: key);

  @override
  State<IssiMobile> createState() => _IssiMobileState();
}

class _IssiMobileState extends State<IssiMobile> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          GetMaterialApp(
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: ThemeService().theme,
            debugShowCheckedModeBanner: false,
            home: const SplashscreenView(),
          ),
          /* OverrideTextScaleFactor(
            textScaleFactor: ConstantConfig().textScale,
            child: UpgradeAlert(
              upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.cupertino),
            ),
          ), */
          //const YoutubePlayer(),
        ],
      ),
    );
  }
}

//+6285659806797