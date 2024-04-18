import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_gallery/services/photo_service.dart';

class PhotoUploadController {
  final _photoService = PhotoService();

  Future<void> uploadPhoto(File imageFile, BuildContext context) async {
    try {
      await _photoService.uploadPhoto(imageFile);
      _showUploadSuccessDialog(context);
    } catch (e) {
      print('Error uploading photo: $e');
    }
  }

  void _showUploadSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Photo uploaded successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
