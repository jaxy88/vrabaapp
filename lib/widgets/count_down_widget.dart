import 'package:flutter/material.dart';

class CountDownWiget extends StatefulWidget {
  final Duration duration;

  const CountDownWiget({super.key, required this.duration});

  @override
  State<CountDownWiget> createState() => _CountDownWigetState();
}

class _CountDownWigetState extends State<CountDownWiget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  String get counterText {
    final Duration count = controller.duration! * controller.value;
    return count.inSeconds.toString();
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);

    controller.reverse(from: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Colors.white,
                    value: controller.value,
                  ),
                ),
              ),
              Text(
                counterText,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
