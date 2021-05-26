import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static void showDialog(BuildContext context) {
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
          'Você está próximo à um campus da PUC, aproveite os benefícios de sua faculdade...',
      btnOkOnPress: () {},
    )..show();
  }

  static Future<void> displayNotification(
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId",
        "Parece que você está perto da Puc",
        "Você pode passar na biblioteca e pegar um livro para leitura, que tal?");

    var details = new NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
        0,
        "Parece que você está perto da Puc",
        "Você pode passar na biblioteca e pegar um livro para leitura, que tal?",
        details);
  }
}
