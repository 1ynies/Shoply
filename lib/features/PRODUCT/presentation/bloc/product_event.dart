abstract class ProductEvent {}

// Triggered when the user enters the page
class LoadProductEvent extends ProductEvent {
  final String productId;
  LoadProductEvent(this.productId);
}

// Triggered when the user taps a size chip (S, M, L, etc.)
class SelectSizeEvent extends ProductEvent {
  final String size;
  SelectSizeEvent(this.size);
}

// Event for selecting an image from the gallery
class SelectImageEvent extends ProductEvent {
  final int index;
  SelectImageEvent(this.index);
}

// Triggered by the + and - buttons
class UpdateQuantityEvent extends ProductEvent {
  final int delta; // +1 for increase, -1 for decrease
  UpdateQuantityEvent(this.delta);
}

// Triggered when the heart icon is tapped
class ToggleFavoriteEvent extends ProductEvent {}