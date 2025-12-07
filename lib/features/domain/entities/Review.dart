class Review {
  final String reviewID;
  final String productID;
  final String userID;
  final int rating; // 1-5
  final String comment;
  final DateTime reviewDate;

  Review({
    required this.reviewID,
    required this.productID,
    required this.userID,
    required this.rating,
    required this.comment,
    required this.reviewDate,
  });
}

