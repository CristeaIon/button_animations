import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ConnectButton(title: 'Flutter Demo Home Page'),
    );
  }
}

class ConnectButton extends StatefulWidget {
  const ConnectButton({super.key, required this.title});

  final String title;

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14265A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 60,
          children: <Widget>[
            CustomButton(color: Color(0xFF47D44F)),
            CustomButton(color: Color(0xFFF6D12E)),
            CustomButton(color: Color(0xFFC35272)),
            CustomButton(color: Color(0xFF5272CC)),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: PQButton(
        width: MediaQuery.sizeOf(context).width * .5,
        height: 80,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.power_settings_new, size: 50, color: Colors.white),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Подключен',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  "00:00:00",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}

enum PQButtonState { connected, connecting, error, disconnected }

class PQButton extends StatefulWidget {
  const PQButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.child,
    this.state = PQButtonState.disconnected,
    this.onPressed,
  });

  final double width;
  final double height;
  final Color color;
  final Widget child;
  final VoidCallback? onPressed;
  final PQButtonState state;

  @override
  State<PQButton> createState() => _PQButtonState();
}

class _PQButtonState extends State<PQButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    // final x = size.width / 2 - widget.width / 2;
    // final dy = size.height / 2 - widget.height / 2;
    return /* AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(x * _waveController.value, 0),
          child: child,
        );
      },
      child:  */ GestureDetector(
      onTap: widget.onPressed,
      child: CustomPaint(
        painter: WavePainter(
          animation: _controller,
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
      /*  ), */
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final BorderRadius borderRadius;

  WavePainter({
    required this.animation,
    required this.color,
    this.borderRadius = BorderRadius.zero,
  }) : super(repaint: animation);

  void _buildWave(Paint paint, Canvas canvas, RRect rect, double value) {
    final waveOffset = value * 10;

    final waveRect = Rect.fromLTRB(
      rect.left - waveOffset,
      rect.top - waveOffset,
      rect.right + waveOffset,
      rect.bottom + waveOffset,
    );

    final waveRRect = RRect.fromRectAndRadius(waveRect, borderRadius.topLeft);

    canvas.drawRRect(
      waveRRect,
      paint
        ..color = color.withValues(
          alpha: (0.7 - (value / 4.0)).clamp(0.0, 1.0),
        ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final buttonRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
    final currentRRect = RRect.fromRectAndRadius(
      buttonRect,
      borderRadius.topLeft,
    );

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    for (var wave = 2; wave >= 0; wave--) {
      _buildWave(paint, canvas, currentRRect, animation.value + wave);
    }

    canvas.drawRRect(currentRRect, paint..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
