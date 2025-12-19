import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplyapp/features/PRODUCT/domain/usecases/get_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductDetails getProductDetailsUseCase;

  ProductBloc({required this.getProductDetailsUseCase}) : super(ProductLoading()) {
    
    // 1. Handle Loading Data
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await getProductDetailsUseCase(event.productId);
        // Reset image index to 0 when loading new product
        emit(ProductLoaded(product: product, selectedImageIndex: 0));
      } catch (e) {
        emit(ProductError("Could not load product details."));
      }
    });

    // 2. Handle Size Selection
    on<SelectSizeEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(currentState.copyWith(selectedSize: event.size));
      }
    });
    // 3. ADDED: Select Image Logic
    on<SelectImageEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(currentState.copyWith(selectedImageIndex: event.index));
      }
    });

    // 3. Handle Quantity Changes
    on<UpdateQuantityEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        // Ensure quantity doesn't go below 1
        final newQuantity = (currentState.quantity + event.delta).clamp(1, 99);
        emit(currentState.copyWith(quantity: newQuantity));
      }
    });

    // 4. Handle Favorite Toggle
    on<ToggleFavoriteEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        // We call the method on the entity
        currentState.product.toggleFavorite();
        // Emit the same product to trigger a UI refresh
        emit(currentState.copyWith(product: currentState.product));
      }
    });
  }
}