import 'package:MoneyBee/Cubits/Transaction Cubit/cubit.dart';
import 'package:MoneyBee/Cubits/Transaction Cubit/states.dart';
import 'package:MoneyBee/Widgets/SwitchTap_Widget.dart';
import 'package:MoneyBee/Widgets/TransCard_Widget.dart';
import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSave(TransactionCubit cubit) async {
    await cubit.saveTransaction(); 
    await cubit.getTotals();
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaction saved!', style: GoogleFonts.poppins()),
        backgroundColor: ThirdColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    _amountController.clear();
    _notesController.clear();
}

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionCubit>();

    return BlocBuilder<TransactionCubit, TransactionStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 247, 235, 252),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Transaction',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Row(
                    children: [
                      SwitchTap_Widget(
                        icon: Icons.remove_circle_outline_rounded,
                        label: 'Expense',
                        active: cubit.isExpense,
                        onTap: () => cubit.setType(true),
                      ),
                      SwitchTap_Widget(
                        icon: Icons.add_circle_outline_rounded,
                        label: 'Income',
                        active: !cubit.isExpense,
                        onTap: () => cubit.setType(false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TransCard_Widget(
                  label: 'AMOUNT',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                          color: cubit.isExpense
                              ? Colors.redAccent
                              : Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          onChanged: (v) =>
                              cubit.setAmount(double.tryParse(v) ?? 0),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade300,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TransCard_Widget(
                  label: 'DATE',
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: cubit.date,
                        firstDate: DateTime(2026),
                        lastDate: DateTime(2030),
                        builder: (ctx, child) => Theme(
                          data: Theme.of(ctx).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: PrimaryColor,
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      if (picked != null) cubit.setDate(picked);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cubit.date.month.toString().padLeft(2, '0')}/${cubit.date.day.toString().padLeft(2, '0')}/${cubit.date.year}',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TransCard_Widget(
                  label: 'NOTES (OPTIONAL)',
                  child: TextField(
                    controller: _notesController,
                    onChanged: cubit.setNotes,
                    style: GoogleFonts.poppins(fontSize: 14),
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Add a note...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                GestureDetector(
                  onTap: () => _onSave(cubit),
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cubit.isExpense ? PrimaryColor : Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          cubit.isExpense
                              ? Icons.remove_circle_outline_rounded
                              : Icons.add_circle_outline_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Save Transaction',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
