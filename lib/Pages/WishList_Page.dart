import 'package:MoneyBee/Cubits/Wish%20List%20Cubit/cubit.dart';
import 'package:MoneyBee/Cubits/Wish%20List%20Cubit/states.dart';
import 'package:MoneyBee/Widgets/WishesDialog_Widget.dart';
import 'package:MoneyBee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return  WishListView();
  }
}

class WishListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WishlistCubit>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 235, 252),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Wish List',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: BlocBuilder<WishlistCubit, WishlistStates>(
        builder: (context, state) {
          if (state is WishlistLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6A0DAD)),
            );
          }

          if (state is WishlistErrorState) {
            return Center(
              child: Text(
                state.message,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          }

          final wishlists = cubit.wishlists;

          return Column(
            children: [
              GestureDetector(
                onTap: () => WishlistDialog(context, cubit),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: PrimaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Add New Wishlist',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: PrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (wishlists.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 60,
                          color: SecondaryColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'No Wish Lists Yet',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: SecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: wishlists.length,
                    itemBuilder: (context, index) {
                      final item = wishlists[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 4,
                          ),
                          leading: const Icon(
                            Icons.favorite_outline,
                            color: PrimaryColor,
                          ),
                          title: Text(
                            item['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Color.fromARGB(255, 250, 108, 108),
                            ),
                            onPressed: () => cubit.deleteWishlist(item['id']),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}