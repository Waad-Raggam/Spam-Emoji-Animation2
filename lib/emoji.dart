import 'package:flutter/animation.dart';

class Emoji {
  AnimationController controller;
  Tween<Offset> startTween;
  Tween<Offset> endTween;
  Tween<double> opacityTween;

  Emoji(this.controller, this.startTween, this.endTween, this.opacityTween);
}
