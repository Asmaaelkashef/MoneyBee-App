import 'package:MoneyBee/Cubits/Transaction Cubit/cubit.dart';
import 'package:MoneyBee/Pages/Statistics_Page.dart';
import 'package:MoneyBee/Widgets/TotalBalance_Widget.dart';
import 'package:MoneyBee/Widgets/TransHistory_Widget.dart';
import 'package:MoneyBee/Widgets/TransStates_Widget.dart';
import 'package:MoneyBee/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen_Content extends StatefulWidget {
  const HomeScreen_Content({super.key});

  @override
  State<HomeScreen_Content> createState() => _HomeScreen_ContentState();
}

class _HomeScreen_ContentState extends State<HomeScreen_Content> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().getTotals();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final firstName = (user?.displayName ?? user?.email ?? 'User')
        .split(' ')
        .first;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 235, 252),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo - Copy.png", height: 35),
                    const SizedBox(width: 10),
                    Text(
                      "MoneyBee",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 102, 102, 102),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [PrimaryColor, Color.fromARGB(255, 228, 177, 247)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    top: 12.0,
                    bottom: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Hello, $firstName",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TotalBalance_Widget(),
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 212, 211, 211),
                      thickness: 1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatisticsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "View Summary",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 102, 102, 102),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 212, 211, 211),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              TransStates_Widget(),
              const SizedBox(height: 16),
              const TransHistory_Widget(),
            ],
          ),
        ),
      ),
    );
  }
}
