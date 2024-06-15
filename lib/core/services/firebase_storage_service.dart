import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<String> userPicture(String userEmail, File image) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child(
            'users') // Optional: You can specify a folder in Firebase Storage
        .child(
            '$userEmail.jpg'); // Set the name of the image to the user's email

    // Upload the image file to Firebase Storage
    final SettableMetadata metadata = SettableMetadata(
      contentType: 'image/jpeg', // Set content type to indicate it's an image
    );
    final UploadTask uploadTask = storageReference.putFile(image, metadata);

    // Wait for the upload to complete
    final TaskSnapshot taskSnapshot = await uploadTask.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw Exception();
      },
    );

    // Get the download URL of the uploaded image
    final String imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }
}
