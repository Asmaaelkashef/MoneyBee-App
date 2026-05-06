import 'package:MoneyBee/Cubits/Wish%20List%20Cubit/cubit.dart';
import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void WishlistDialog(BuildContext context, WishlistCubit cubit) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(
          'New Wishlist',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: PrimaryColor,
          ),
        ),
        content: TextField(
          controller: controller,
          onChanged: cubit.setName,
          decoration: InputDecoration(
            hintText: 'enter Wishlist',
            hintStyle: GoogleFonts.poppins(color: Colors.grey , fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
          onSubmitted: (_) {
            Navigator.pop(context);
            cubit.saveWishlist();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              cubit.reset();
              Navigator.pop(context);
            },
            child:Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey),),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.saveWishlist();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child:Text('Save', style: GoogleFonts.poppins(color: Colors.white),),
          ),
        ],
      ),
    );
  }