import 'package:flutter/material.dart';
import 'package:myapp/widgets/post.dart';
import 'package:myapp/widgets/board.dart';
import 'package:myapp/widgets/under_construction.dart';
import 'package:myapp/widgets/whois.dart';
import 'widgets/madew.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const portfolio());
}

// ignore: camel_case_types
class portfolio extends StatelessWidget {
  const portfolio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamlesh Savale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kamlesh Savale'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            WhoIs(),
            UnderConstruction(),
            Board(),
            Post(),
            MadeWith(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
