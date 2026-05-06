import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFiled_Widget extends StatefulWidget {
  const CustomTextFiled_Widget({
    super.key,
    required this.controller,
    required this.labelText,
    this.icon,
    this.isPassword = false,
    this.focusNode,
  });

  final TextEditingController controller;
  final String labelText;
  final Icon? icon;
  final bool isPassword;
  final FocusNode? focusNode;

  @override
  State<CustomTextFiled_Widget> createState() =>
      _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFiled_Widget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.labelText == 'Password' ||
        widget.labelText == 'Confirm Password';

    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      obscureText: isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 197, 196, 196),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: PrimaryColor),
        ),
        prefixIcon: widget.icon,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}