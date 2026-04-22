import 'package:flutter/material.dart';

class ResetPasswordAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFECECEC),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
      ),
      title: const Text(
        'Reset Password',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
