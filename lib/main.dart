import 'package:flutter/material.dart';
import 'package:myapp/widgets/post.dart';
import 'package:myapp/widgets/board.dart';
import 'package:myapp/widgets/whois.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kamlesh A Savale'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WhoIs(),
            Board(),
            Post(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
