import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  final String name;
  final String email;

  const UserProfileWidget({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_outline,
            color: Colors.grey.shade400,
            size: 32,
          ),
        ),
        const SizedBox(width: 16),
        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserProfileCardWidget extends StatelessWidget {
  final String name;
  final String email;

  const UserProfileCardWidget({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: UserProfileWidget(name: name, email: email),
    );
  }
}
