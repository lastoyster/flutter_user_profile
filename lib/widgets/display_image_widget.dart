import 'dart:io';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(64, 105, 225, 1);
    final imageProvider = _getImageProvider();

    return Center(
      child: Stack(
        children: [
          _buildImage(color, imageProvider),
          Positioned(
            child: _buildEditIcon(color),
            right: 4,
            top: 10,
          ),
        ],
      ),
    );
  }

  ImageProvider<Object> _getImageProvider() {
    if (imagePath.startsWith('https://')) {
      return NetworkImage(imagePath);
    } else {
      return FileImage(File(imagePath));
    }
  }

  Widget _buildImage(Color color, ImageProvider<Object> imageProvider) {
    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: imageProvider,
        radius: 70,
      ),
    );
  }

  Widget _buildEditIcon(Color color) {
    return _buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ),
    );
  }

  Widget _buildCircle({
    required double all,
    required Widget child,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ),
    );
  }
}
