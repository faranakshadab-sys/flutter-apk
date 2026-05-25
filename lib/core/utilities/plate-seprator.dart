extension PlateSeprator on String {
  List<String> getSepratedPlate() {
    return [
      this.substring(0, 2),
      this.substring(2, 3),
      this.substring(3, 6),
      this.substring(6, 8)
    ];
  }
}
