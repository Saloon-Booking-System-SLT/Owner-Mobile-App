import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../lang/language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Start animation
    _animationController.forward();

    // Navigate after delay
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Language()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFF5F5F5),
            child: Column(
              children: [
                // Main content area
                Expanded(
                  flex: 4,
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // App Icon
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                              ),
                              child: const Center(child: SalonIcon()),
                            ),

                            const SizedBox(height: 40),

                            // App Title
                            const Text(
                              'Salon',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1976D2),
                                letterSpacing: 1.0,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Subtitle
                            const Text(
                              'Find Your Perfect Hair\nSalon',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // SLT Mobitel Logo Section
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const SLTMobitelLogo(),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom Salon Icon Widget
class SalonIcon extends StatelessWidget {
  const SalonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(80, 80), painter: SalonIconPainter());
  }
}

class SalonIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Draw zigzag mountain pattern to match the image
    final startX = size.width * 0.25;
    final startY = size.height * 0.65;

    path.moveTo(startX, startY);
    path.lineTo(size.width * 0.42, size.height * 0.35);
    path.lineTo(size.width * 0.58, size.height * 0.48);
    path.lineTo(size.width * 0.75, size.height * 0.28);

    canvas.drawPath(path, paint);

    // Draw circle (dot) in the lower left area
    final circleCenter = Offset(size.width * 0.35, size.height * 0.75);
    canvas.drawCircle(circleCenter, size.width * 0.06, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// SLT Mobitel Logo Widget
class SLTMobitelLogo extends StatelessWidget {
  const SLTMobitelLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo design with colored bars matching the image
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BCD4),
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
            const SizedBox(width: 2),
            Container(
              width: 3,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
            const SizedBox(width: 2),
            Container(
              width: 3,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
            const SizedBox(width: 12),
            // Text
            const Text(
              'SLTMOBITEL',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        const Text(
          'The Connection',
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}