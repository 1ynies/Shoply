import 'package:shoplyapp/core/error/fealure.dart';
import 'package:shoplyapp/core/util/either.dart';
import 'package:shoplyapp/features/domain/entities/Product_entity.dart';
import 'package:shoplyapp/features/domain/repository/product_repository.dart';

/// Business logic: fetch products, handle failure, return entity.
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(String categoryID) async {
    // Optional: Add pre-checks or post-processing logic here.
    return await repository.getProductsByCategory(categoryID);
  }
}