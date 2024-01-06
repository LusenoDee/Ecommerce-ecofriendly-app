import 'package:eccomercelive/controllers/product_controller.dart';
import 'package:eccomercelive/models/product_model.dart';
import 'package:eccomercelive/services/database_service.dart';
import 'package:eccomercelive/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable


class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Mascara',
      'Makeup Kit',
      'Skin care products',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Product'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            ImagePicker _picker = ImagePicker();
                            final XFile? _image = await _picker.pickImage(
                                source: ImageSource.gallery);
      
                            if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 6),
                                  content: Text('No image was selected.'),
                                ),
                              );
                            }
      
                            if (_image != null) {
                              await storage.uploadImage(_image);
                              var imageUrl =
                                  await storage.getDownloadURL(_image.name);
      
                              productController.newProduct.update(
                                  'imageUrl', (_) => imageUrl,
                                  ifAbsent: () => imageUrl);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  elevation: 2,
                                  backgroundColor: Colors.white38,
                                  duration: Duration(seconds: 5),
      
                                  content: Text('Image Uploaded to Firebase.'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Add an Image',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Product Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTextFormField(
                  'Product Name',
                  'name',
                  productController,
                ),
                _buildTextFormField(
                  'Product Description',
                  'description',
                  productController,
                ),
                DropdownButtonFormField(
                  iconSize: 20,
                  decoration: const InputDecoration(hintText: 'Product Category'),
                  items: categories.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    productController.newProduct.update(
                      'category',
                      (_) => value,
                      ifAbsent: () => value,
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildSlider(
                  'Price',
                  'price',
                  productController,
                  productController.price,
                ),
                _buildSlider(
                  'Quantity',
                  'quantity',
                  productController,
                  productController.quantity,
                ),
                const SizedBox(height: 10),
                _buildCheckbox(
                  'Recommended',
                  'isRecommended',
                  productController,
                  productController.isRecommended,
                ),
                _buildCheckbox(
                  'Popular',
                  'isPopular',
                  productController,
                  productController.isPopular,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                     try {
      
                       database.addProduct(
                        Product(
                          name: productController.newProduct['name'],
                          category: productController.newProduct['category'],
                          description:
                              productController.newProduct['description'],
                          imageUrl: productController.newProduct['imageUrl'],
                          isRecommended:
                              productController.newProduct['isRecommended'] ??
                                  false,
                          isPopular:
                              productController.newProduct['isPopular'] ?? false,
                          price: productController.newProduct['price'],
                          quantity:
                              productController.newProduct['quantity'].toInt(),
                        ),
                      );
                      Fluttertoast.showToast(
                              msg: 'Product saved successfully!',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.white,
                              textColor: Colors.black26,
                              fontSize: 16.0,
                              timeInSecForIosWeb: 6,
                              webBgColor:
                                  "#FFFFFF", // Background color for web (if needed)
                              webPosition:
                                  "right", // Position for web (if needed)
                              webShowClose:
                                  true, // Show close button on web (if needed)
                            );
                      Get.back();
      
                      } catch (e) {
                         debugPrint('eror! $e');
                            Fluttertoast.showToast(
                              msg: 'Error! Product not saved: $e',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0,
                              timeInSecForIosWeb: 1,
                              webBgColor:
                                  "#FFFFFF", // Background color for web (if needed)
                              webPosition:
                                  "right", // Position for web (if needed)
                              webShowClose:
                                  true, // Show close button on web (if needed)
                            );
                     }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildCheckbox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

  Row _buildSlider(
    String title,
    String name,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}



/*
class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key});
  final ProductController controller = Get.find();
  StorageService storage = StorageService();
  // instance of firebase db
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add a Product')),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            ImagePicker _picker = ImagePicker();
                            final XFile? _image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (_image == null) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please Select an Image to upload!')));
                            }

                            if (_image != null) {
                              await storage.uploadImage(_image);
                              var imageUrl =
                                  await storage.getDownloadURL(_image.name);

                              controller.newProduct.update(
                                'imageUrl',
                                (value) => imageUrl,
                                ifAbsent: () => imageUrl,
                              );

                              debugPrint(controller.newProduct['imageUrl']);
                              // show success message
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.blueGrey,
                                      padding: EdgeInsets.all(25),
                                      content:
                                          Text('Success! image uploaded!')));
                            }
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Add an image',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  'Product Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                _buildTextFormFirld('Product ID', 'id', controller),
                _buildTextFormFirld('Product Name', 'name', controller),
                _buildTextFormFirld(
                    'Product Description', 'description', controller),
                _buildTextFormFirld(
                    'Product CategoryName', 'category', controller),
                _buildSlider('Price', 'price', controller, controller.price),
                _buildSlider(
                    'Quantity', 'quantity', controller, controller.quantity),
                const SizedBox(
                  height: 10,
                ),
                _buildCheckBox('Recommended', 'isRecommended', controller,
                    controller.isRecommended),
                _buildCheckBox(
                    'Popular', 'isPopular', controller, controller.isPopular),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        debugPrint(controller.newProduct.toString());
                        try {
                          database.addProduct(
                            Product(
                              id: controller.newProduct['id'],
                              name: controller.newProduct['name'],
                              category: controller.newProduct['category'],
                              description: controller.newProduct['description'],
                              imageUrl: controller.newProduct['imageUrl'],
                              isRecommended:controller.newProduct['isRecommended'],
                              isPopular: controller.newProduct['isPopular'],
                              price: controller.newProduct['price'], // Convert price to string
                              quantity: int.parse(controller.newProduct['quantity']),
                            ),
                          );
                          Fluttertoast.showToast(
                            msg: 'Product saved successfully!',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0,
                            timeInSecForIosWeb: 1,
                            webBgColor:
                                "#FFFFFF", // Background color for web (if needed)
                            webPosition:
                                "right", // Position for web (if needed)
                            webShowClose:
                                true, // Show close button on web (if needed)
                          );
                        } catch (e) {
                          debugPrint('eror! $e');
                          Fluttertoast.showToast(
                            msg: 'Error! Product not saved: $e',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0,
                            timeInSecForIosWeb: 1,
                            webBgColor:
                                "#FFFFFF", // Background color for web (if needed)
                            webPosition:
                                "right", // Position for web (if needed)
                            webShowClose:
                                true, // Show close button on web (if needed)
                          );
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// one of my best
  TextFormField _buildTextFormFirld(
    String hintText,
    String name,
    ProductController controller,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: (value) {
        controller.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }

  _buildSlider(
    String title,
    String name,
    ProductController controller,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            max: 100,
            min: 0,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              controller.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  _buildCheckBox(
    String title,
    String name,
    ProductController controller,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          onChanged: (value) {
            controller.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
          checkColor: Colors.black,
          activeColor: Colors.black54,
        ),
      ],
    );
  }
}
*/ 