class DbException implements Exception {
  final String message;

  const DbException({
    required this.message,
  });
}
