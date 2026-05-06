import 'package:MoneyBee/Cubits/Transaction%20Cubit/cubit.dart';
import 'package:MoneyBee/Cubits/Transaction%20Cubit/states.dart';
import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalBalance_Widget extends StatelessWidget {
  const TotalBalance_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionStates>(
      builder: (context, state) {
        final cubit = context.read<TransactionCubit>();
        final balance = cubit.totalIncome - cubit.totalExpense;
        return Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: SecondaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance : ",
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$ ${balance.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}