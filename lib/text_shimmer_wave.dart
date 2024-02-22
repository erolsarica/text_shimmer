
import 'package:flutter/material.dart';

import 'text_shimmer.dart';

class TextShimmerWave extends StatefulWidget {
  const TextShimmerWave({super.key});

  static PageRoute route() =>
      MaterialPageRoute(builder: (_) => const TextShimmerWave());

  @override
  State<TextShimmerWave> createState() => _TextShimmerWaveState();
}

class _TextShimmerWaveState extends State<TextShimmerWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animationController
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const text = 'Merhaba, nasılsınız?';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'English',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'Hi, how are you?',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Turkish',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF56CED0),
                                ),
                              ),
                              AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        text.length,
                                        (index) => TextShimmer(
                                          key: ValueKey('$index'),
                                          animationController:
                                              _animationController,
                                          length: text.length,
                                          char: text[index],
                                          index: index + 1,
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.pause_circle_rounded,
                          color: Color(0xFF3A777B),
                          size: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

