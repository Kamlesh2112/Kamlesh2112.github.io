import 'package:flutter/material.dart';
import 'package:myapp/constants/global_variable.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    String now = DateTime.now().toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color(GlobalVariables.postbody),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color(GlobalVariables.postheader),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.more_vert),
                  const Text(
                    'Anonymous',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 0, 113, 4),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Text(
                    now,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              alignment: Alignment.topLeft,
              child: const Text(
                '> be me\n> flutter developer',
                style: TextStyle(
                  color: Color(GlobalVariables.greentext),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
