import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipark_sharing/models/home_model.dart';
import 'package:ipark_sharing/screens/splash_screen.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); //portraitDown
  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel()),
      ],
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xff140620),
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light));
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.dark(),
            fontFamily: 'Montserrat-Bold',
            primaryColorBrightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            secondaryHeaderColor: Colors.white,
            brightness: Brightness.dark,
            splashColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          initialRoute: SplashScreen.routeName,
          //routes: appRoutes,
        );
      },
    );
  }
}