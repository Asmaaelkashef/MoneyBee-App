import 'package:MoneyBee/Cubits/Wish%20List%20Cubit/states.dart';
import 'package:MoneyBee/Data/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistStates> {
  WishlistCubit() : super(WishlistInitialState());
  final DataBase _db = DataBase();

  List<Map<String, dynamic>> wishlists = [];
  String name = '';

  void setName(String value) {
    name = value;
  }

  Future<void> getWishlists() async {
    emit(WishlistLoadingState());
    try {
      final result = await _db.readData(
        'SELECT * FROM wishlists ORDER BY id DESC',
      );
      wishlists = result;
      emit(WishlistLoadedState(wishlists: wishlists));
    } catch (e) {
      emit(WishlistErrorState(message: e.toString()));
    }
  }

  Future<void> saveWishlist() async {
    if (name.trim().isEmpty) return;
    try {
      await _db.insertData(
        "INSERT INTO wishlists (name) VALUES ('${name.trim().replaceAll("'", "''")}')",
      );
      name = '';
      await getWishlists();
      emit(WishlistSavedState());
    } catch (e) {
      emit(WishlistErrorState(message: e.toString()));
    }
  }

  Future<void> deleteWishlist(int id) async {
    try {
      await _db.deleteData('DELETE FROM wishlists WHERE id = $id');
      emit(WishlistDeletedState());
      await getWishlists();
    } catch (e) {
      emit(WishlistErrorState(message: e.toString()));
    }
  }

  void reset() {
    name = '';
    emit(WishlistInitialState());
  }
}