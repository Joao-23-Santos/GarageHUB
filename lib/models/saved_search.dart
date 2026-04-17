class SavedSearch {
  final String id;
  final String name;
  final int listingCount;
  final int newListingsToday;
  final Map<String, dynamic> filters;

  SavedSearch({
    required this.id,
    required this.name,
    required this.listingCount,
    required this.newListingsToday,
    required this.filters,
  });
}
