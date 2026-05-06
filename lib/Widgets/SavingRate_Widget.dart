import 'package:MoneyBee/Cubits/Transaction%20Cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavingRate_Widget extends StatelessWidget {
  final TransactionCubit cubit;

  const SavingRate_Widget({required this.cubit});

  @override
  Widget build(BuildContext context) {
    double savingsRate = 0.0;

    if (cubit.totalIncome > 0) {
      double saved = cubit.totalIncome - cubit.totalExpense;
      savingsRate = (saved / cubit.totalIncome) * 100;
    }
    bool isPositive = savingsRate >= 0;
    

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Savings Rate',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? Colors.green : Colors.redAccent,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                '${savingsRate.toStringAsFixed(1)}%',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.green : Colors.redAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: isPositive ? savingsRate / 100 : 0,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(
                isPositive ? Colors.green : Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
