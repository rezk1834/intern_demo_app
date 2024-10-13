import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/item_model.dart';
import '../repositories/item_repository.dart';

// Main Page Events
abstract class MainPageEvent {}
class FetchItems extends MainPageEvent {}
class SearchItems extends MainPageEvent {
  final String query;
  SearchItems(this.query);
}

// Main Page States
abstract class MainPageState {}
class MainPageInitial extends MainPageState {}
class MainPageLoading extends MainPageState {}
class MainPageLoaded extends MainPageState {
  final List<Item> items;
  MainPageLoaded(this.items);
}
class MainPageError extends MainPageState {
  final String error;
  MainPageError(this.error);
}

// BLoC Implementation
class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final ItemRepository itemRepository;

  MainPageBloc({required this.itemRepository}) : super(MainPageInitial());

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if (event is FetchItems) {
      yield MainPageLoading();
      try {
        final items = await itemRepository.fetchItems();
        yield MainPageLoaded(items);
      } catch (e) {
        yield MainPageError("Failed to load items.");
      }
    } else if (event is SearchItems) {
      // Add filtering logic for search
      if (state is MainPageLoaded) {
        final allItems = (state as MainPageLoaded).items;
        final filteredItems = allItems.where((item) =>
            item.title.contains(event.query)
        ).toList();
        yield MainPageLoaded(filteredItems);
      }
    }
  }
}
