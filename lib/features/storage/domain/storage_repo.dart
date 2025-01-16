import 'dart:typed_data';

abstract class StorageRepo {
  // upload images on mobile platforms
  Future<String?> uploadProfileImageMobile(String path, String fileName);

  // upload images on web platforms
   Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);

   // upload images on mobile platforms
  Future<String?> uploadPostImageMobile(String path, String fileName);

  // upload images on web platforms
   Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName);

}
