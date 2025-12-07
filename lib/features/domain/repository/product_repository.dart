import 'package:shoplyapp/core/error/fealure.dart';
import 'package:shoplyapp/core/util/either.dart';
import 'package:shoplyapp/features/domain/entities/Product_entity.dart';

/// Abstract interface for fetching products and related data.
abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      String categoryID);
  Future<Either<Failure, List<String>>> getSearchHistory(String userID);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
  Future<Either<Failure, bool>> toggleFavorite(String userID, String productID);
}