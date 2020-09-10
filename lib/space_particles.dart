import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:space_animation/particle_animated.dart';
import 'package:space_animation/particle_painter.dart';

class SpaceParticles extends StatefulWidget {
  final int numberOfParticles;
  SpaceParticles(this.numberOfParticles);
  @override
  _SpaceParticlesState createState() => _SpaceParticlesState();
}

class _SpaceParticlesState extends State<SpaceParticles> {
  final Random random = Random();
  final List<ParticleModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}
