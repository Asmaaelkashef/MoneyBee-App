import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignbygoogleWidget extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback? onPressed; 

  const SignbygoogleWidget({
    super.key,
    required this.text,
    required this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 20, height: 20),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}