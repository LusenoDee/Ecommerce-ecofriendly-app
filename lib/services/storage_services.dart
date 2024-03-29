import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class StorageService {
  // instance of firebase_storage
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    
    //upload image as an object using putFile
    await storage.ref('product_images/${image.name}').putFile(File(image.path));

  }

  Future<String> getDownloadURL(String imageName) async {
    String downloadURL =
        await storage.ref('product_images/$imageName').getDownloadURL();

    return downloadURL;
  }
}