import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snp_garbage_collection/src/core/helper/helper.dart';

import 'package:snp_garbage_collection/src/core/widgets/elevated_button.view.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Container(
        child: ElevatedButtonView(
          onPressed: _onPress,
          child: const Text('Camera'),
        ),
      ),
    );
  }

  Future<void> _onPress() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 500,
      imageQuality: 50,
    );

    logger.i(photo?.path);

    // getting a directory path for saving
    final String path = (await getApplicationDocumentsDirectory()).path;

    final savePath = '$path/image1.jpg';

// copy the file to a new path
    await photo?.saveTo(savePath);
    logger.i(savePath);
  }
}
