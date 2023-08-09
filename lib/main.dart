import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Spam Button Icon')),
        body: Center(
          child: SpamButtonIcon(),
        ),
      ),
    );
  }
}

class SpamButtonIcon extends StatefulWidget {
  @override
  _SpamButtonIconState createState() => _SpamButtonIconState();
}

class _SpamButtonIconState extends State<SpamButtonIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isAnimating = false;
  Alignment _currentAlignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
  }

  void _startAnimation() {
    _animationController.repeat(reverse: true);
    setState(() {
      _isAnimating = true;
    });
  }

  void _stopAnimation() {
    _animationController.stop();
    setState(() {
      _isAnimating = false;
      _currentAlignment =
          Alignment.center; // Reset the position when animation stops
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _startAnimation(),
      onTapUp: (_) => _stopAnimation(),
      onTapCancel: () => _stopAnimation(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          if (_isAnimating) {
            // Interpolate the position of the icon between the center and the top of the screen.
            double animationValue = _animationController.value;
            double startX = 0.0;
            double startY = 0.0;
            double endX = 0.0;
            double endY = -1.0;

            double interpolatedX = startX + (endX - startX) * animationValue;
            double interpolatedY = startY + (endY - startY) * animationValue;

            _currentAlignment = Alignment(interpolatedX, interpolatedY);
          }
          return Stack(
            children: [
              Align(
                alignment: _currentAlignment,
                child: Icon(
                  Icons.face,
                  size: 50.0,
                  color: Colors.yellow,
                ),
              ),
              Align(
                alignment: _currentAlignment,
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.face,
                      size: 50,
                      color: Colors.green,
                    )),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
