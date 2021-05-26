import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttermap/components/map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    initialSettings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for i
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color(0xFF158185),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    //notity
                    show();
                  },
                  child: Icon(
                    Icons.autorenew_outlined,
                    size: 26.0,
                  ),
                )),
          ]),
      body: MapComponent(),
    );
  }

  show() {
    displayNotification("Parece que você está perto da Puc",
        "Você pode passar na biblioteca e pegar um livro para leitura, que tal?");

    AwesomeDialog(
      context: context,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.green, width: 2),
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      showCloseIcon: true,
      title: 'UHUUUUU!!!',
      desc:
          'Você está em um campus da PUC, aproveite os benefícios de sua faculdade...',
      btnOkOnPress: () {},
    )..show();
  }

  Future<void> displayNotification(String title, String message) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId",
        "Parece que você está perto da Puc",
        "Você pode passar na biblioteca e pegar um livro para leitura, que tal?");

    var details = new NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(0, title, message, details);
  }
}

void initialSettings() async {
  var androidConfig = AndroidInitializationSettings("app_icon");
  var settings = InitializationSettings(android: androidConfig);

  await notificationsPlugin.initialize(settings);
}
