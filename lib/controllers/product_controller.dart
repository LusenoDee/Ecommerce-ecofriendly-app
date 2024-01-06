import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomercelive/models/product_model.dart';
import 'package:eccomercelive/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService database = DatabaseService();
  var products = <Product>[].obs;

  @override
  void onInit() {
   products.bindStream(database.getProducts());
    //fetchProducts();
   /*  products.listen((List<Product> productList) {
    for (Product product in productList) {
      debugPrint('Product ID: ${product.id}');
      debugPrint('Name: ${product.name}');
      debugPrint('Category: ${product.category}');
      debugPrint('Description: ${product.description}');
      debugPrint('Image URL: ${product.imageUrl}');
      debugPrint('Is Recommended: ${product.isRecommended}');
      debugPrint('Is Popular: ${product.isPopular}');
      debugPrint('Price: ${product.price}');
      debugPrint('Quantity: ${product.quantity}');
      debugPrint('---------------------------');
    }
  }); */
    super.onInit();
  }
  Future<void> fetchProducts() async {
    // Simulated fetching of products or use your database logic here
    // For example, if using Firebase Firestore:
    await firestore.collection('products').get().then((snapshot) {
      snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
   });
    
    // Simulated data (replace with actual fetching logic)
    //products.assignAll(Product.products); // Assigning sample data for demonstration
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

   void saveNewProductPrice(
    Product product,
    String field,
    double value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductPrice(
    int index,
    Product product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }

 
  void updateProductQuantity(
    int index,
    Product product,
    int value,
  ) {
    product.quantity = value;
    products[index] = product;
  }

   void saveNewProductQuantity(
    Product product,
    String field,
    int value,
  ) {
    database.updateField(product, field, value);
  }

  
}