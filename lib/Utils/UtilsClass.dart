class UtilsClass {
  static String hideCharacters(String input, int keepVisible) {
    if (input.length <= keepVisible) {
      return input;
    }

    return input.replaceRange(
        keepVisible, input.length, '*' * (input.length - keepVisible));
  }
}
