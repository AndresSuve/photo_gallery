import 'package:flutter/material.dart';
import 'package:photo_gallery/controllers/photo_gallery_controller.dart';
import 'package:photo_gallery/models/photo.dart';
import 'package:photo_gallery/screens/upload_photo_screen.dart';

class PhotoGalleryScreen extends StatefulWidget {
  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final PhotoGalleryController _controller = PhotoGalleryController();

  @override
  void initState() {
    super.initState();
    _controller.loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _controller.loadPhotos,
          ),
        ],
      ),
      body: StreamBuilder<List<Photo>>(
        stream: _controller.photosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Photo>? photos = snapshot.data;
            if (photos != null && photos.isNotEmpty) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    photos[index].url,
                    fit: BoxFit.cover,
                  );
                },
              );
            } else {
              return Center(child: Text('No photos available'));
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadPhotoScreen()),
          );
        },
        tooltip: 'Upload Photo',
        child: Icon(Icons.add),
      ),
    );
  }
}
