import 'package:flutter/material.dart';

class SalonSplashScreen extends StatelessWidget {
  const SalonSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/hairdresser.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            children: [
              // Top decorative elements
              Expanded(
                flex: 1,
                child: _buildTopDecoration(),
              ),
              
              // Main content
              Expanded(
                flex: 2,
                child: _buildMainContent(),
              ),
              
              // Bottom section with loading
              Expanded(
                flex: 1,
                child: _buildBottomSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopDecoration() {
    return Stack(
      children: [
        Positioned(
          top: 50,
          right: 30,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 40,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8B4A8).withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Elegant logo container
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 3,
                offset: Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.8),
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              // Background pattern
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFE8B4A8).withOpacity(0.1),
                      Color(0xFFE8B4A8).withOpacity(0.3),
                    ],
                  ),
                ),
              ),
              Center(
                child: Icon(
                  Icons.content_cut_rounded,
                  size: 70,
                  color: Color(0xFFE8B4A8),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        // App name with decorative elements
        Stack(
          alignment: Alignment.center,
          children: [
            // Decorative underline
            Container(
              width: 120,
              height: 4,
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE8B4A8).withOpacity(0),
                    Color(0xFFE8B4A8),
                    Color(0xFFE8B4A8).withOpacity(0),
                  ],
                ),
              ),
            ),
            
            Column(
              children: [
                Text(
                  'Glamour',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    letterSpacing: 3,
                    fontFamily: 'PlayfairDisplay', // Use an elegant font
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Studio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 8,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Tagline with icon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 12,
              color: Color(0xFFE8B4A8),
            ),
            const SizedBox(width: 8),
            Text(
              'Beauty Redefined',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 1.5,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.star,
              size: 12,
              color: Color(0xFFE8B4A8),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Decorative dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 2 
                    ? Color(0xFFE8B4A8)
                    : Colors.white.withOpacity(0.4),
              ),
            );
          }),
        ),
        
        const SizedBox(height: 30),
        
        // Loading text with decorative border
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Loading...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
            ),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Bottom decorative elements
        _buildBottomDecoration(),
      ],
    );
  }

  Widget _buildBottomDecoration() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '✦',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}