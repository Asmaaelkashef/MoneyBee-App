abstract class WishlistStates {}

class WishlistInitialState extends WishlistStates {}

class WishlistLoadingState extends WishlistStates {}

class WishlistLoadedState extends WishlistStates {
  final List<Map<String, dynamic>> wishlists;
  WishlistLoadedState({required this.wishlists});
}

class WishlistSavedState extends WishlistStates {}

class WishlistDeletedState extends WishlistStates {}

class WishlistErrorState extends WishlistStates {
  final String message;
  WishlistErrorState({required this.message});
}