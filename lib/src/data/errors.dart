class DamError implements Exception {
  final String message;
  DamError(this.message);

  @override
  String toString() => message;
}
