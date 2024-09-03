import 'package:flutter/material.dart';
import 'package:myapp/constants/global_variable.dart';
import 'package:myapp/models/maps.dart';
import 'package:myapp/widgets/board_section.dart';

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 500,
      width: 500,
        decoration: BoxDecoration(
          color:const Color(GlobalVariables.skinbody),
        border: Border.all(color: Colors.black),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color(GlobalVariables.skinheader),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Board',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:  Color(GlobalVariables.brown),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 3,
                children: <Widget>[
                  BoardSection(header: "projects", textLinks: projectsMap),
                  BoardSection(header: "skills", textLinks: skillsMap),
                  BoardSection(header: "socials", textLinks: socialsMap),
                ],
              ),
            ),
          ],
        ),
    );
  }
}