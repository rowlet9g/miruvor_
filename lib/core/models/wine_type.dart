enum WineType {
  red('Red'),
  white('White'),
  rose('Rose'),
  sparkling('Sparkling'),
  fortified('Fortified'),
  dessert('Dessert'),
  other('Other');

  const WineType(this.label);

  final String label;
}
