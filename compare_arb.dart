import 'dart:convert';
import 'dart:io';

void main() {
  final fileAr = File('lib/l10n/app_ar.arb');
  final fileEn = File('lib/l10n/app_en.arb');

  final dataAr = jsonDecode(fileAr.readAsStringSync()) as Map<String, dynamic>;
  final dataEn = jsonDecode(fileEn.readAsStringSync()) as Map<String, dynamic>;

  final keysAr = dataAr.keys.toSet();
  final keysEn = dataEn.keys.toSet();

  print('Keys only in EN (missing in AR):');
  for (final key in keysEn) {
    if (!key.startsWith('@') && !keysAr.contains(key)) {
      print('  - $key');
    }
  }

  print('\nKeys only in AR (missing in EN):');
  for (final key in keysAr) {
    if (!key.startsWith('@') && !keysEn.contains(key)) {
      print('  - $key');
    }
  }
}
