extension StringUtilities on String {
  trimBeyond(int length, {String replacement = "..."}) {
    if (this.length > length) {
      return substring(0, length + 1) + replacement;
    } else {
      return this;
    }
  }
}

extension IntegerUtilities on int {
  pad0(int length) {
    return toString().padLeft(length, '0');
  }
}
