import 'package:ame/singleton/locator.dart';
import 'package:ame/resources/app_colors.dart';
import 'package:ame/resources/lightTheme.dart';
import 'package:ame/utilities/app_assets.dart';
import 'package:ame/utilities/size_fitter.dart';
import 'package:ame/utilities/view_utilities/constants.dart';
import 'package:ame/utilities/view_utilities/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  setAppUp();
  //runApp(const MyApp());
}

void setAppUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setLocatorUp();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    SizeUtil().init(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      isScaffoldGreen: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Image.asset(
                  AppAssets.ameLogo,
                  scale: 4.0,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'WELCOME TO ATLANTIC \n MUSIC EXPO',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ],
            ),
            // ElevatedButton(
            //     onPressed: () {},
            //     child: const Text(
            //       'Continue',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //           color: AppColors.ameSplashScreenBgColor, fontSize: 20),
            //     ))
          ],
        ),
      ),
    );
  }
}
