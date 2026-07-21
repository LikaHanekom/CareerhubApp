/// The signed-in user, decoded straight out of the access token's JWT
/// payload. This is never fetched from a REST endpoint, never written to
/// Isar, and never serialised back to JSON — it exists purely as an
/// in-memory representation of "who does the current token belong to."
class User {
  final String id;
  final String email;
  final String displayName;

  const User({
    required this.id,
    required this.email,
    required this.displayName,
  });
}