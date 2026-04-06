import 'dart:io';
import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('FileExtensions', () {
    group('nameWithOutExtensions', () {
      test('should return file name without extension', () {
        final file = File('/path/to/file.txt');
        expect(file.nameWithOutExtensions, 'file');
      });

      test('should handle file with multiple dots', () {
        final file = File('/path/to/file.name.with.dots.txt');
        expect(file.nameWithOutExtensions, 'file.name.with.dots');
      });

      test('should handle file without extension', () {
        final file = File('/path/to/filename');
        expect(file.nameWithOutExtensions, 'filename');
      });

      test('should handle file with dot at start', () {
        final file = File('/path/to/.hidden');
        expect(file.nameWithOutExtensions, '.hidden');
      });
    });

    group('fileName', () {
      test('should return file name with extension', () {
        final file = File('/path/to/file.txt');
        expect(file.fileName, 'file.txt');
      });

      test('should handle file with multiple dots', () {
        final file = File('/path/to/file.name.with.dots.txt');
        expect(file.fileName, 'file.name.with.dots.txt');
      });

      test('should handle file without extension', () {
        final file = File('/path/to/filename');
        expect(file.fileName, 'filename');
      });

      test('should handle file with dot at start', () {
        final file = File('/path/to/.hidden');
        expect(file.fileName, '.hidden');
      });

      test('should handle file in root directory', () {
        final file = File('/file.txt');
        expect(file.fileName, 'file.txt');
      });
    });
  });
}
