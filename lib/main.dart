import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_animation/space_particles.dart';

void main(List<String> args) {
  runApp(SpaceParticlesApp());
}

class SpaceParticlesApp extends StatelessWidget {
  List<Widget> _createParticles(int numParticles) {
    final particles = <Widget>[];
    for (var i = 0; i < numParticles; i++) {
      particles.add(
        _createStaticParticle(),
      );
    }
    return particles;
  }

  Widget _createStaticParticle() {
    final _random = Random();
    final particleSize = 1.0;
    return Builder(
      builder: (BuildContext context) {
        final topOffset = _random.nextDouble() *
            (MediaQuery.of(context).size.height - particleSize);
        final leftOffset = _random.nextDouble() *
            (MediaQuery.of(context).size.width - particleSize);
        return Positioned(
          top: topOffset,
          left: leftOffset,
          child: Container(
            width: 0.2 + (particleSize - 0.2) * _random.nextDouble(),
            height: 0.2 + (particleSize - 0.2) * _random.nextDouble(),
            color: Colors.white,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(child: SpaceParticles(60)),
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Final Frontier',
                        style: GoogleFonts.orbitron(
                            fontSize: 40,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Stack(
                  children: _createParticles(200),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
