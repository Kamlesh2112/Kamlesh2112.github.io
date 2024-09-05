import 'package:flutter/material.dart';
import 'package:myapp/constants/global_variable.dart';

class WhoIs extends StatelessWidget {
  const WhoIs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          // height:100,
          width: MediaQuery.of(context).size.width * 0.5 < 500
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color:const Color(GlobalVariables.postbackgroundpurple),
          border: Border.all(color: Colors.black),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: const Color(GlobalVariables.brown),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Who is kamlesh?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Full stack developer with expertise in Flutter, Firebase, NodeJs and MongoDB.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
