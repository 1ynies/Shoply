import 'package:shoplyapp/features/PRODUCT/domain/entities/Product_entity.dart';
import 'package:shoplyapp/features/PRODUCT/domain/repositories/product_repository.dart';

class GetProductDetails {
  final ProductRepository repository;
  GetProductDetails(this.repository);

  Future<ProductEntity> call(String id) async {
    return await repository.getProductDetails(id);
  }
}



