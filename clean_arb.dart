import 'dart:convert';
import 'dart:io';

void cleanArb(String path) {
  final file = File(path);
  if (!file.existsSync()) return;

  final content = file.readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(content);

  // Sort keys to make it deterministic
  final sortedKeys = data.keys.toList()..sort();
  final Map<String, dynamic> sortedData = {};

  for (final key in sortedKeys) {
    sortedData[key] = data[key];
  }

  const encoder = JsonEncoder.withIndent('  ');
  file.writeAsStringSync(encoder.convert(sortedData));
  print('Cleaned $path');
}

void main() {
  cleanArb('lib/l10n/app_ar.arb');
  cleanArb('lib/l10n/app_en.arb');
}
