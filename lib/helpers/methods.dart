import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Methods {

  Future<void> uploadImageToFirebase(List<dynamic> images, {required String name, required String price, required dynamic amenities}) async {
    if (images == null || images.isEmpty) return;


    print(images);
    List<String> uploadedImages = [];

  /*  for (var image in images) {
      // Check if image is of type File. If it's not, convert it.
      File fileToUpload;

      fileToUpload = File(image);

      // Create a unique file name
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.png';

      try {
        // Upload the file to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = storageRef.putFile(fileToUpload);

        // Wait until the upload is complete
        await uploadTask;

        // Get the download URL of the uploaded file
        final downloadUrl = await storageRef.getDownloadURL();
        print("Download URL: $downloadUrl");

        uploadedImages.add(downloadUrl);
      } catch (e) {
        print("Upload failed: $e");
      }
    }*/

    // Upload the data to Firestore
    Map<String, dynamic> toUploadData = {
      "name": name,
      "amenities": amenities,
      "price": price,
      "images": uploadedImages, // Add the uploaded image URLs
    };

    await FirebaseFirestore.instance.collection('rooms').add(toUploadData);
    print("Data uploaded successfully.");
  }
}