import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const double _width = 300.0;
const double _height = 500.0;
const Duration _duration = Duration(seconds: 10);
final Tween _animationTween = Tween(begin: 0.0, end: _height);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _animation = _animationTween.animate(_controller);
    _animation.addListener(() {
      if (_animation.isCompleted) {
        _controller.repeat();
        _createParticles(200);
      }
    });
    _controller.forward();
  }

  Widget _createAnimatedParticle() {
    final _random = math.Random();
    final particleSize = 2.0;
    final particle = AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget widget) {
        return Transform.translate(
          offset: Offset(0.0, -_animation.value),
          child: Container(
            width: particleSize,
            height: particleSize,
            color: Colors.white,
          ),
        );
      },
    );

    final topOffset = _random.nextDouble() * (_height - particleSize);
    final leftOffset = _random.nextDouble() * (_width - particleSize);
    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: particle,
    );
  }

  List<Widget> _createParticles(int numParticles) {
    final particles = <Widget>[];
    for (var i = 0; i < numParticles; i++) {
      particles.add(_createAnimatedParticle());
    }
    //TODO make concurrent animated particles
    return particles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          width: _width,
          height: _height,
          child: Stack(
            children: _createParticles(200),
          ),
        ),
      ),
    );
  }
}
