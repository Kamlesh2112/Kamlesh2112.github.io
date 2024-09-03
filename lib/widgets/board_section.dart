import 'package:flutter/material.dart';
import 'package:myapp/constants/global_variable.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BoardSection extends StatelessWidget {
  final String header;
  final Map<String, String?> textLinks;
  const BoardSection(
      {super.key, required this.header, required this.textLinks});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          header,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(GlobalVariables.brown),
            fontSize: 10,
            decoration: TextDecoration.underline,
          ),
        ),
        for (var entry in textLinks.entries)
          GestureDetector(
            onTap: entry.value != null
                ? () {
                    _openLink(context, entry.value!);
                  }
                : null,
            child: Text(
              entry.key,
              style: entry.value != null
                  ? const TextStyle(
                      fontSize: 10,
                      color: Color(GlobalVariables.brown),
                      decoration: TextDecoration.underline,
                    )
                  : const TextStyle(color: Color(GlobalVariables.brown)),
            ),
          ),
      ],
    );
  }

  Future<void> _openLink(BuildContext context, String url) async {
    if (!await launchUrlString(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
