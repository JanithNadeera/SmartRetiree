import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:smart_retiree/utils/core_utils.dart';

class ImageUpload {
  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    try {
      const String cloudName = 'dqaeqrs2n';
      const String uploadPreset = 'asela123456';
      // const String apiKey = '724941716134316';

      final uri =
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      // Read the response stream once and store it in a variable
      final responseBody = await response.stream.bytesToString();
      log("Cloudinary response: $responseBody");

      if (response.statusCode == 200) {
        log("SUCCESSFULLY UPLOADED IMAGE");

        // Parse the response body
        final jsonResponse = jsonDecode(responseBody);
        final imageUrl =
            jsonResponse['secure_url']; // Get the URL of the uploaded image

        return imageUrl;
      } else {
        CoreUtils.showToast(
            type: ToastType.error, message: 'Failed to upload image');
        return null;
      }
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Failed to upload image');
      rethrow;
    }
  }
}
