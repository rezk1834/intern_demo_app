import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ItemRepository {
  // Base URL of the API
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Item>> fetchItems({int page = 1, int limit = 10}) async {
    // Fetch all items from the API
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Calculate the starting index for pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      // Return a subset of the list based on pagination
      if (startIndex >= data.length) {
        return []; // No more items to fetch
      }

      // Slice the data to simulate pagination
      final paginatedData = data.sublist(
          startIndex,
          endIndex > data.length ? data.length : endIndex
      );

      return paginatedData
          .map((json) => Item.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}

