import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class LinearIndicator extends StatefulWidget {
  const LinearIndicator({super.key});

  @override
  State<LinearIndicator> createState() => _LinearIndicatorState();
}

class _LinearIndicatorState extends State<LinearIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 5,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.primary.withAlpha(64),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Align(
                alignment: Alignment(_animation.value * 2 - 1, 0),
                child: Container(
                  width: 25,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
