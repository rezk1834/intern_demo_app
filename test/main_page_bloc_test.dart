import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intern_demo_app/blocs/main_page_bloc.dart';
import 'package:intern_demo_app/models/item_model.dart';
import 'package:intern_demo_app/repositories/item_repository.dart';

import 'package:mockito/mockito.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  group('MainPageBloc', () {
    late MainPageBloc mainPageBloc;
    late MockItemRepository mockItemRepository;

    setUp(() {
      mockItemRepository = MockItemRepository();
      mainPageBloc = MainPageBloc(itemRepository: mockItemRepository);
    });

    test('initial state is MainPageInitial', () {
      expect(mainPageBloc.state, MainPageInitial());
    });

    blocTest<MainPageBloc, MainPageState>(
      'emits [MainPageLoading, MainPageLoaded] when FetchItems is added',
      build: () {
        when(mockItemRepository.fetchItems())
            .thenAnswer((_) async => [Item(title: 'Test Item', id: 0, body: '')]);
        return mainPageBloc;
      },
      act: (bloc) => bloc.add(FetchItems()),
      expect: () => [MainPageLoading(), MainPageLoaded([Item(title: 'Test Item', id: 0, body: '')])],
    );

    blocTest<MainPageBloc, MainPageState>(
      'emits [MainPageLoading, MainPageError] when FetchItems fails',
      build: () {
        when(mockItemRepository.fetchItems()).thenThrow(Exception('Failed to load items.'));
        return mainPageBloc;
      },
      act: (bloc) => bloc.add(FetchItems()),
      expect: () => [MainPageLoading(), isA<MainPageError>()],
    );

    blocTest<MainPageBloc, MainPageState>(
      'emits [MainPageLoaded] when SearchItems is added',
      build: () {
        mainPageBloc.emit(MainPageLoaded([Item(title: 'Test Item', id: 0, body: ''), Item(title: 'Another Item', id: 0, body: '')]));
        return mainPageBloc;
      },
      act: (bloc) => bloc.add(SearchItems('Test')),
      expect: () => [
        MainPageLoaded([Item(title: 'Test Item', id: 0, body: '')]),
      ],
    );

    tearDown(() {
      mainPageBloc.close();
    });
  });
}
