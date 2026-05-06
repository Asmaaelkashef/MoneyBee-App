String? validateSignUp({
  required String username,
  required String email,
  required String password,
  required String confirmPassword,
}) {
  username = username.trim();
  email = email.trim();

  if (username.isEmpty) return 'Username is required.';
  if (email.isEmpty) return 'Email is required.';

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) return 'Enter a valid email.';

  if (password.length < 6) return 'Password must be at least 6 characters.';
  if (password != confirmPassword) return 'Passwords do not match.';

  return null;
}