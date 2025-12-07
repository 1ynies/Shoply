class SearchHistory {
  final String historyID;
  final String userID;
  final String searchQuery;
  final DateTime searchTime;

  SearchHistory({
    required this.historyID,
    required this.userID,
    required this.searchQuery,
    required this.searchTime,
  });
}