void main() {
  var s = '090807555';
  print('Original: $s');
  print('replaceRange(2, 6, "****"): ${s.replaceRange(2, 6, "****")}');
  print('replaceRange(2, 2+4, "****"): ${s.replaceRange(2, 6, "****")}');
}
