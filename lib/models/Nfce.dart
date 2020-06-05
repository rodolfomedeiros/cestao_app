class Nfce {
  static final RegExp keyFormat = RegExp('[0-9]{44}');

  String key;

  Nfce(this.key);

  factory Nfce.fromRawContent(String rawContent) {
    Nfce nfce = Nfce(Nfce.keyFormat.stringMatch(rawContent));

    return nfce.key != null ? nfce : Nfce("");
  }
}
