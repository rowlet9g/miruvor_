String formatKrw(num? value) {
  if (value == null) return '가격 미상';
  final text = value.toStringAsFixed(value == value.roundToDouble() ? 0 : 2);
  final parts = text.split('.');
  final whole = parts.first;
  final buffer = StringBuffer();
  for (var i = 0; i < whole.length; i++) {
    buffer.write(whole[i]);
    final remaining = whole.length - i;
    if (remaining > 1 && remaining % 3 == 1) buffer.write(',');
  }
  if (parts.length > 1) buffer.write('.${parts[1]}');
  return 'KRW $buffer';
}

String formatDate(DateTime? value) {
  if (value == null) return '날짜 미상';
  return '${value.year}.${value.month.toString().padLeft(2, '0')}.${value.day.toString().padLeft(2, '0')}';
}
