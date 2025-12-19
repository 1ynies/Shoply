import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoplyapp/features/PRODUCT/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> getProductDetails(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<ProductModel> getProductDetails(String id) async {
    final snapshot = await firestore.collection('products').doc(id).get();
    if (snapshot.exists) {
      return ProductModel.fromFirestore(snapshot.data()!, id);
    } else {
      throw Exception('Product not found');
    }
  }
}
