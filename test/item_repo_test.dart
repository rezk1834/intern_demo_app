import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intern_demo_app/models/item_model.dart';
import 'package:intern_demo_app/repositories/item_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late ItemRepository itemRepository;
  late MockClient client;

  setUp(() {
    client = MockClient();
    itemRepository = ItemRepository(client: client);
  });
  test('returns a list of items when the http call completes successfully', () async {
    // Mock response data
    final mockResponseData = [
      {
        "userId": 1,
        "id": 1,
        "title": "Sample Title",
        "body": "Sample Body"
      },
    ];

    when(client.get(Uri.parse(itemRepository.apiUrl)))
        .thenReturn(Future.value(http.Response(json.encode(mockResponseData), 200)));

    final result = await itemRepository.fetchItems(page: 1, limit: 3);
    expect(result, isA<List<Item>>());
    expect(result.length, 1); // Check if the returned list has the expected length
  });


  test('throws an exception if the http call completes with an error', () async {
    // Set up the mock response for a failed request
    when(client.get(Uri.parse(itemRepository.apiUrl)))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    expect(
          () async => await itemRepository.fetchItems(page: 1, limit: 3),
      throwsA(isA<Exception>()),
    );
  });

  test('returns an empty list when no items are available', () async {
    // Set up the mock response for a successful empty request
    when(client.get(Uri.parse(itemRepository.apiUrl)))
        .thenAnswer((_) async => http.Response('[]', 200));

    final result = await itemRepository.fetchItems(page: 1, limit: 3);
    expect(result, isA<List<Item>>());
    expect(result, isEmpty);
  });
}
