import 'package:flutter/material.dart';
import 'package:flutter_animation_sample_1/emoji.dart';
import 'dart:math';

class EmojiAnimationScreen extends StatefulWidget {
  @override
  _EmojiAnimationScreenState createState() => _EmojiAnimationScreenState();
}

class _EmojiAnimationScreenState extends State<EmojiAnimationScreen>
    with TickerProviderStateMixin {
  List<String> images = [
    'assets/images/angry.png',
    'assets/images/wow.png',
    'assets/images/haha.png',
    'assets/images/love.png',
    'assets/images/sad.png',
  ];
  List<List<Emoji>> emojiLists = [];
  int currentIndex = 0;
  int randomIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  int generateRandomIndex() {
    return Random().nextInt(5); // Randomly selet the index form images list
  }

  void _startAnimation() {
    emojiLists.clear();

    for (String image in images) {
      List<Emoji> emojis = [];

      for (int i = 0; i < 1; i++) {
        AnimationController controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        );

        Tween<Offset> startTween = Tween<Offset>(
          begin: const Offset(0.5, 0.5), // Middle of the screen
          end: const Offset(1.0, 1.0), // Off the screen
        );

        Tween<Offset> endTween = Tween<Offset>(
          begin: Offset(Random().nextDouble(), Random().nextDouble()),
          end: Offset(Random().nextDouble(), Random().nextDouble()),
        );

        Tween<double> opacityTween = Tween<double>(
          begin: 1.0,
          end: 0.0,
        );

        Emoji emoji = Emoji(controller, startTween, endTween, opacityTween);
        emojis.add(emoji);

        controller.forward();
      }

      emojiLists.add(emojis);
    }
  }

  void _restartAnimation() {
    for (var emojiList in emojiLists) {
      for (var emoji in emojiList) {
        emoji.controller.dispose();
      }
      emojiList.clear();
    }
    setState(() {
      randomIndex = generateRandomIndex();
      _startAnimation();
    });
  }

  @override
  void dispose() {
    for (var emojiList in emojiLists) {
      for (var emoji in emojiList) {
        emoji.controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emoji Animation')),
      body: Center(
        child: Stack(
          children: emojiLists.asMap().entries.map((entry) {
            int index = currentIndex;
            List<Emoji> emojis = entry.value;

            return Stack(
              children: emojis.map((emoji) {
                return AnimatedBuilder(
                  animation: emoji.controller,
                  builder: (context, child) {
                    double progress = emoji.controller.value;
                    Offset currentOffset = Offset.lerp(
                      emoji.startTween.begin,
                      emoji.endTween.end,
                      progress,
                    )!;

                    double opacity =
                        emoji.opacityTween.evaluate(emoji.controller);
                    return Positioned(
                      left:
                          currentOffset.dx * MediaQuery.of(context).size.width,
                      top:
                          currentOffset.dy * MediaQuery.of(context).size.height,
                      child: Opacity(
                        opacity: opacity,
                        child: SizedBox(
                          width: 20 +
                              ((1 - opacity) *
                                  30), // Decrease width as opacity increases
                          height: 20 +
                              ((1 - opacity) *
                                  30), // Decrease height as opacity increases
                          child: Image.asset(
                            images[randomIndex],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _restartAnimation,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
