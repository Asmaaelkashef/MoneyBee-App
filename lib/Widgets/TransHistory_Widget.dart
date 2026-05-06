import 'package:MoneyBee/Cubits/Transaction Cubit/cubit.dart';
import 'package:MoneyBee/Cubits/Transaction Cubit/states.dart';
import 'package:MoneyBee/Pages/TransactionsHistory_Page.dart';
import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TransHistory_Widget extends StatefulWidget {
  const TransHistory_Widget({super.key});

  @override
  State<TransHistory_Widget> createState() => _TransHistory_WidgetState();
}

class _TransHistory_WidgetState extends State<TransHistory_Widget> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().getRecentTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionStates>(
      builder: (context, state) {
        final transactions = context.read<TransactionCubit>().recentTransactions;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 8.0, top: 6),
                child: Row(
                  children: [
                    Text(
                      "Recent Transactions",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 102, 102, 102),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TransactionsHistory_Page(),
                          ),
                        );
                      },
                      child: Text(
                        "View More",
                        style: GoogleFonts.poppins(fontSize: 10, color: PrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              if (transactions.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No transactions yet!',
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    final isExpense = t['isExpense'] == 1;
                    final amount = t['amount'];
                    final notes = t['notes'] ?? '';

                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isExpense
                              ? Colors.red.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                          color: isExpense ? Colors.redAccent : Colors.green,
                          size: 18,
                        ),
                      ),
                      title: Text(
                        isExpense ? 'Expense' : 'Income',
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      subtitle: notes.isNotEmpty
                          ? Text(notes, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey))
                          : null,
                      trailing: Text(
                        '${isExpense ? '-' : '+'}$amount\$',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isExpense ? Colors.redAccent : Colors.green,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}