extension StringToBool on String {
  toBool() {
    return this.toLowerCase() == 'true';
  }
}
