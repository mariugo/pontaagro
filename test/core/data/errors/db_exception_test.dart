import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';

void main() {
  const dbException = DbException(message: 'Test message');

  group('dbExceptions', () {
    test('should be instance of DbException', () {
      expect(dbException, isA<DbException>());
    });
    test('should be instance of Exception', () {
      expect(dbException, isA<Exception>());
    });
    test('should have a message', () {
      expect(dbException.message, isNotEmpty);
    });
  });
}
