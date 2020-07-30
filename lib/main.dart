import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  List<int> _num = [];
  int _size = 500;

  StreamController<List<int>> _streamController;
  Stream _stream;

  _randomize() {
    _num = [];

    for (int i = 0; i < _size; i++) {
      _num.add(Random().nextInt(_size));
    }
    // setState(() {});
    _streamController.add(_num);
  }

  _sort() async {
    print('reach');
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size - i - 1; j++) {
        if (_num[j] > _num[j + 1]) {
          int temp = _num[j];
          _num[j] = _num[j + 1];
          _num[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        // setState(() {});
        _streamController.add(_num);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;
    _randomize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bubble Sort'),
        backgroundColor: Color(0xFF0E4D64),
      ),
      body: Container(
        child: StreamBuilder<Object>(
          stream: _stream,
          builder: (context, snapshot) {
            int count = 0;
            
            return Row(
              children: _num.map((int n) {
                count++;
                return CustomPaint(
                  painter: BarPainter(
                    width: MediaQuery.of(context).size.width / _size,
                    value: n, index: count),
                );
              }).toList(),
            );
          }
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Text('Randomize'),
              onPressed: _randomize,
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Text('Sort'),
              onPressed: _sort,
            ),
          )
        ],
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Color(0xFFDEEDCF);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFFBFE1B0);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF99D492);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFF74C67A);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFF56B870);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFF39A96B);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFF1D9A6C);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFF188977);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFF137177);
    } else {
      paint.color = Color(0xFF0E4D64);
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 0),
        Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
