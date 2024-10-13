import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';


class ItemRepository {
  // The base URL of the API
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Method to fetch items from the API
  Future<List<Item>> fetchItems({int page = 1, int limit = 10}) async {
    // Calculate the starting index for pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    // Fetch all items from the API
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> data = json.decode(response.body);

      // Return a subset of the list based on pagination
      return data.sublist(startIndex, endIndex > data.length ? data.length : endIndex)
          .map((json) => Item.fromJson(json))
          .toList();
    } else {
      // Throw an exception if the API call fails
      throw Exception('Failed to load items');
    }
  }
}
