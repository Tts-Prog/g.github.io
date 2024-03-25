//void piece() {
Map<String, String> accentMap = {
  'á': 'a', 'à': 'a', 'ã': 'a', 'â': 'a', 'ä': 'a',
  'Á': 'A', 'À': 'A', 'Ã': 'A', 'Â': 'A', 'Ä': 'A',
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'É': 'E', 'È': 'E', 'Ê': 'E', 'Ë': 'E',
  'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
  'Í': 'I', 'Ì': 'I', 'Î': 'I', 'Ï': 'I',
  'ó': 'o', 'ò': 'o', 'õ': 'o', 'ô': 'o', 'ö': 'o',
  'Ó': 'O', 'Ò': 'O', 'Õ': 'O', 'Ô': 'O', 'Ö': 'O',
  'ú': 'u', 'ù': 'u', 'ũ': 'u', 'û': 'u', 'ü': 'u',
  'Ú': 'U', 'Ù': 'U', 'Ũ': 'U', 'Û': 'U', 'Ü': 'U',
  'ç': 'c', 'Ç': 'C'
  // Add more mappings as needed for other accented characters
};

String portugueseText = 'Olá, tudo bem?';
String englishText = translateToEnglish(portugueseText, accentMap);
// print(englishText); // Output: Ola, tudo bem?
//}

String translateToEnglish(String text, Map<String, String> accentMap) {
  String translatedText = '';
  for (int i = 0; i < text.length; i++) {
    String char = text[i];
    if (accentMap.containsKey(char)) {
      translatedText += accentMap[char]!;
    } else {
      translatedText += char;
    }
  }
  return translatedText;
}
