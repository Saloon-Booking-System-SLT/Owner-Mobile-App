import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/lang/select_language.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFECECEC),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LanguageSelectionScreen(),
            ),
          );
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 28,
        ),
      ),
      title: const Text(
        'Login To Your Salon',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
