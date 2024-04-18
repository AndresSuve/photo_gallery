import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '/models/photo.dart';

class PhotoService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<List<Photo>> getPhotos() async {
    firebase_storage.ListResult result =
    await _storage.ref('photo-gallery/').listAll();

    List<Photo> photos = [];
    for (var photoRef in result.items) {
      String downloadUrl = await photoRef.getDownloadURL();
      photos.add(Photo(url: downloadUrl));
    }
    return photos;
  }



  Future<void> uploadPhoto(File imageFile) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = _storage.ref('photo-gallery/$imageName.jpg');
    firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask;
  }
}
