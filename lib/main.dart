import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui show Image;
import 'dart:async';

void main() => runApp(new MyApp());

Sprite _car;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NodeWithSize rootNode;
  EventHandlingNode eventHandingNode;

  ui.Image _image;

  ImageMap images = new ImageMap(rootBundle);
  Future<Null> _loadAssets() async {
    _image = await images.loadImage('assets/car.png');
    _car = new Sprite.fromImage(_image);
    _car.position = const Offset(350.0, 200.0);

    //rootNode.addChild(_car);
    eventHandingNode.addChild(_car);
  }

  @override
  void initState() {
    super.initState();
    //rootNode = new NodeWithSize(const Size(1024.0, 1024.0));
    eventHandingNode = new EventHandlingNode(const Size(1024.0, 1024.0));
    _loadAssets();
// .then((_) {
//      setState(() {
//
//      });
//    });
  }

  changeCarPosition() {
    _car.position = const Offset(350.0, 500.0);
  }

  @override
  Widget build(BuildContext context) {
    return new SpriteWidget(eventHandingNode);
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Game'),
//        ),
//        body: Center(
//          child: Text('Welcome'),
//        ),
//      ),
//    );
  }
}

class EventHandlingNode extends NodeWithSize {
  EventHandlingNode(Size size) : super(size) {
    userInteractionEnabled = true;
  }

  @override
  handleEvent(SpriteBoxEvent event) {
    if (event.type == PointerDownEvent) {
      print('PointerDownEvent');
      _car.position = const Offset(350.0, 500.0);
    } else if (event.type == PointerMoveEvent) print('PointerMoveEvent');

    return true;
  }
}
