import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final Ticker _ticker;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _ticker = createTicker((elapsed) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          color: Colors.white,
          child: CustomPaint(
            size: const Size(
              double.infinity,
              800,
            ),
            painter: ClockPainter(dateTime: _dateTime),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter({required this.dateTime});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 82, paint3);
    canvas.drawCircle(center, 80, paint);
    canvas.drawCircle(center, 30, paint2);

    final paintHourHand = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    final paintMinuteHand = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    final paintSecondHand = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    final hourHandLength = 50.0;
    final minuteHandLength = 70.0;
    final secondHandLength = 90.0;

    final hourHandX = center.dx +
        hourHandLength *
            cos((dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180 -
                pi / 2);
    final hourHandY = center.dy +
        hourHandLength *
            sin((dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180 -
                pi / 2);

    final minuteHandX = center.dx +
        minuteHandLength * cos(dateTime.minute * 6 * pi / 180 - pi / 2);
    final minuteHandY = center.dy +
        minuteHandLength * sin(dateTime.minute * 6 * pi / 180 - pi / 2);

    final secondHandX = center.dx +
        secondHandLength * cos(dateTime.second * 6 * pi / 180 - pi / 2);
    final secondHandY = center.dy +
        secondHandLength * sin(dateTime.second * 6 * pi / 180 - pi / 2);

    canvas.drawLine(center, Offset(hourHandX, hourHandY), paintHourHand);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), paintMinuteHand);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), paintSecondHand);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.dateTime != dateTime;
  }
}
