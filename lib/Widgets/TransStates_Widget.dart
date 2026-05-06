import 'package:MoneyBee/Cubits/Transaction%20Cubit/cubit.dart';
import 'package:MoneyBee/Cubits/Transaction%20Cubit/states.dart';
import 'package:MoneyBee/Widgets/TransInfo_Widget.dart';
import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransStates_Widget extends StatelessWidget {
  const TransStates_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionStates>(
      builder: (context, state) {
        final cubit = context.read<TransactionCubit>();
        return Column(
          children: [
            TransInfo_Widget(
              icon: Icons.arrow_upward,
              title: "Expenses",
              amount: "\$ ${cubit.totalExpense.toStringAsFixed(2)}",
              iconColor: const Color.fromARGB(255, 206, 25, 12),
              textColor: const Color.fromARGB(255, 206, 25, 12),
            ),
            const SizedBox(height: 8),
            TransInfo_Widget(
              icon: Icons.arrow_downward,
              title: "Income",
              amount: "\$ ${cubit.totalIncome.toStringAsFixed(2)}",
              iconColor: PrimaryColor,
              textColor: PrimaryColor,
            ),

          ],
        );
      },
    );
  }
}
