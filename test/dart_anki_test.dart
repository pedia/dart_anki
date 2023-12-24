import 'package:dart_anki/dart_anki.dart';
import 'package:test/test.dart';

void main() {
  group('Basic reading tests', () {
    late AnkiInstance instance;

    setUp(() {
      instance = AnkiInstance('test/japanese_basic_hiragana.apkg');
    });

    test('Test members', () {
      expect(instance.files.length, equals(48));
      expect(instance.resources.length, equals(46));
      expect(instance.cards.length, equals(46));
      expect(instance.cards.first.id, equals(1296169988801));
    });

    tearDown(() {
      instance.dispose();
    });
  });

  // Todo: add creation tests
  group('Basic creation tests', () {
    test('test create', () {
      final instance = AnkiInstance('newt', create: true);
      // expect(instance.db.select('SELECT sql FROM sqlite_schema').rows.length, 5);
      expect(instance.cards, isEmpty);
      expect(instance.resources, isEmpty);
      instance.dispose();
    });
  });
}
