import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

class Utils {
  static Utils instance = Utils();
  static Utils getInstance() {
    return instance;
  }

  launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log("Error Launching the link");
    }
  }
}
