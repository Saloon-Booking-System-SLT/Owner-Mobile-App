import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const HomeBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      iconSize: 22,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      onTap: (index) {
        if (onTap != null) {
          onTap!(index);
          return;
        }
      },
      selectedItemColor: const Color(0xFF4A3FFF),
      unselectedItemColor: Colors.grey.shade600,
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer_outlined),
          label: 'Manage',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Income',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
