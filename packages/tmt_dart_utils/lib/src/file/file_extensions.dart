import 'dart:io';
import 'package:path/path.dart';

extension FileExtensions on File {
  String get nameWithOutExtensions => basenameWithoutExtension(this.path);
  String get fileName => basename(this.path);
}
