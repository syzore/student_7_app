import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_7_app/services/image_service.dart';
import '../config.dart';

class MemoService {
  final String baseUrl = '${ServerAPI.baseUrl}/api/memos';

  Future<List<dynamic>> fetchMemos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Process image paths using ImageService
      for (var item in data) {
        item['imagePath'] = await ImageService.getProcessedImageUrl(item['imagePath']);
      }

      return data;
    } else {
      throw Exception('Failed to load memos');
    }
  }

  Future<Map<String, dynamic>> fetchMemoById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/id/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Update image paths to include the full API URL
      data['imagePath'] = await ImageService.getProcessedImageUrl(data['imagePath']);

      return data;
    } else {
      throw Exception('Failed to load this chat');
    }
  }
}
