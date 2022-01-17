enum NewsCategory {
  business,
  entertainment,
  health,
  politics,
  science,
  sports,
  technology,
  top,
  world,
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
