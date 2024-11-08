import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
class ParticleWidget extends StatefulWidget {
  const ParticleWidget({super.key});

  @override
  State<ParticleWidget> createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<ParticleWidget> {

  List<Particle> createParticles() {
    var rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < 30; i++) {
      particles.add(Particle(
        // color: Colors.white.withOpacity(0.6),
        color: getRandomColor().withOpacity(0.6),
        size: rng.nextDouble() * 10,
        velocity: Offset(rng.nextDouble() * 200 * randomSign(),
            rng.nextDouble() * 200 * randomSign()),
      ));
    }
    return particles;
  }
  Color getRandomColor() {
    var rng = Random();
    return Color.fromARGB(
      255,
      rng.nextInt(256),
      rng.nextInt(256),
      rng.nextInt(256),
    );
  }
  double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1 : -1;
  }
  @override
  Widget build(BuildContext context) {
    return  Particles(
      awayRadius: 150,
      particles: createParticles(), // List of particles
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      onTapAnimation: true,
      awayAnimationDuration: const Duration(milliseconds: 100),
      awayAnimationCurve: Curves.linear,
      enableHover: false,
      hoverRadius: 90,
      connectDots: false,
    );
  }
}
