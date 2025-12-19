import 'package:shoplyapp/core/error/Failure.dart';
import 'package:shoplyapp/features/PRODUCT/domain/entities/Product_entity.dart';

abstract class ProductRepository {
  Future< ProductEntity> getProductDetails(String id);
}
