import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Avatar extends StatefulWidget {
    const Avatar({
    Key? key, required this.icon,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final double? size;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File? avatarImage;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => avatarImage = imagePermanent);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImage(ImageSource.gallery),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 66,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 65,
              child: avatarImage != null
                  ? ClipOval(
                      child: Image.file(avatarImage as File,
                          width: 130, height: 130, fit: BoxFit.cover))
                  : SvgPicture.asset(
                      'assets/images/profilepic.svg',
                      width: 130,
                      height: 130,
                    ),
            ),
          ),
          
          Positioned(
            child: Container(
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: (() {}),
                icon: FaIcon(
                  widget.icon,
                  size: widget.size ?? 25,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
