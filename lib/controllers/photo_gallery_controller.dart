import 'dart:async';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/services/photo_service.dart';

class PhotoGalleryController {
  final _photoService = PhotoService();
  late StreamController<List<Photo>> _photosController;

  Stream<List<Photo>> get photosStream => _photosController.stream;

  PhotoGalleryController() {
    _photosController = StreamController<List<Photo>>.broadcast();
  }

  void loadPhotos() async {
    try {
      List<Photo> photos = await _photoService.getPhotos();
      _photosController.add(photos);
    } catch (e) {
      _photosController.addError('Failed to load photos: $e');
    }
  }

  void dispose() {
    _photosController.close();
  }
}
