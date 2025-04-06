extension stringExtension on String {
  bool convertToBoolean() {
    return this.toLowerCase() == 'true';
  }

  String getFirstName() {
    if (this.split(' ').isNotEmpty) {
      return this.split(' ').first;
    }
    return this;
  }
}
