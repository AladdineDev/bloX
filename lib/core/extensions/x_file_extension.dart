import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart' as mime;

extension XFileExtension on XFile {
  static const imageMimeType = 'image/';
  static const videoMimeType = 'video/';

  bool get isImage {
    final mimeType = mime.lookupMimeType(path);
    return mimeType?.startsWith(imageMimeType) == true;
  }

  bool get isVideo {
    final mimeType = mime.lookupMimeType(path);
    return mimeType?.startsWith(videoMimeType) == true;
  }
}
