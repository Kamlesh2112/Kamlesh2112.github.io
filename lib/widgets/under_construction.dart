import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse('https://chatgpt.com/');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw Exception('Could not launch $url');
        }
      },
      onLongPress: () async {
        final Uri url = Uri.parse('https://www.4chan.org/');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw Exception('Could not launch $url');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.4,
        child: Center(
          child: Lottie.network(
              'https://lottie.host/84eec5c5-5604-4b9f-9351-1183897f1232/mZseZwVqaW.json'),
        ),
      ),
    );
  }
}
