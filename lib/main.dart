import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Date and Time App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamController<DateTime> _dateTimeController;
  late Stream<DateTime> dateTimeStream;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Initialize StreamController and Stream
    _dateTimeController = StreamController<DateTime>();
    dateTimeStream = _dateTimeController.stream;

    // Update the stream every second
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _dateTimeController.add(DateTime.now());
    });
  }

  @override
  void dispose() {
    _dateTimeController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Date and Time'),
      ),
      body: Center(
        child: StreamBuilder<DateTime>(
          stream: dateTimeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String formattedDate = DateFormat('MMMM d, y').format(snapshot.data!);
              String formattedTime = DateFormat('H:mm:ss').format(snapshot.data!);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Date: $formattedDate',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Time: $formattedTime',
                    style: TextStyle(fontSize:35),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
