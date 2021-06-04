import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttermap/models/Locale.dart';

class NotificationService {
  static void showSuccesDialog(BuildContext context, Locale? result) {
    String title = 'UHUUUUU!!!';

    var pucName = result?.name;

    var message = "Você está próximo ao campus " +
        pucName.toString() +
        ", curta os benefícios da sua faculdade...";

    showDialog(context, DialogType.SUCCES, title, message);
  }

  static void showErrorDialog(BuildContext context) {
    const String title = 'Ooopsss...';
    const String message =
        'Ocorreu um erro durante a excecução verifique se sua localização está ativa!';

    showDialog(context, DialogType.ERROR, title, message);
  }

  static void showWarningDialog(BuildContext context) {
    const String title = 'Ainda não...';
    const String message =
        'Você ainda não está próximo à um campus da PUC, ande um pouco mais e logo encontrará um...';

    showDialog(context, DialogType.WARNING, title, message);
  }

  static void showDialog(
      BuildContext context, DialogType type, String title, String message) {
    AwesomeDialog(
      context: context,
      btnOkColor: getColor(type),
      buttonsBorderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: getColor(type), width: 2),
      dialogType: type,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      showCloseIcon: true,
      title: title,
      desc: message,
      autoHide: Duration(milliseconds: 20000),
      btnOkOnPress: () {},
    )..show();
  }

  static MaterialColor getColor(DialogType type) {
    if (type == DialogType.SUCCES) {
      return Colors.green;
    }

    if (type == DialogType.WARNING) {
      return Colors.orange;
    }

    return Colors.red;
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
