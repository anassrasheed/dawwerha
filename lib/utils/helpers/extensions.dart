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

  String generateValidMobileNumber() {
    if (this.length == 10 && this[0] == '0') return this;
    if (this.length == 10 && this[0] != 0) return '0' + this.substring(1);

    if (this.length == 9 && this[0] == '7') {
      return '0' + this;
    }
    return this;
  }
}
