import 'homepage.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> importVid () async {
  final ImagePicker _picker = ImagePicker();

  final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);

  return image;
}


Future<String> getGif (String word){
  return storageRef.child("$word.gif").getDownloadURL();
}




