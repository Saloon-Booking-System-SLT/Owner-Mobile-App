import 'package:flutter/material.dart';

class CustomerCommentWidget extends StatelessWidget {
  final String comment;

  const CustomerCommentWidget({Key? key, required this.comment}) : super(key: key);

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
      child: Text(
        comment,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
