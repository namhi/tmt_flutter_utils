void main() {
  var s = '090807555';
  print('Original: $s (${s.length} chars)');

  // Test 1: with end=6
  var result1 = s.replaceRange(2, 6, '****');
  print('replaceRange(2, 6, "****"): $result1 (${result1.length} chars)');

  // Test 2: with end=null
  var result2 = s.replaceRange(2, null, '****');
  print('replaceRange(2, null, "****"): $result2 (${result2.length} chars)');

  // Test 3: with end=3
  var result3 = s.replaceRange(2, 3, '*');
  print('replaceRange(2, 3, "*"): $result3 (${result3.length} chars)');

  // Test 4: edge case
  var s2 = '123';
  var result4 = s2.replaceRange(0, 3, '*');
  print('123.replaceRange(0, 3, "*"): $result4 (${result4.length} chars)');
}
