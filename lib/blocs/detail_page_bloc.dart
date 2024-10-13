import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/item_model.dart';

// Detail Page Events
abstract class DetailPageEvent {}
class LoadItemDetails extends DetailPageEvent {
  final Item item;
  LoadItemDetails(this.item);
}

// Detail Page States
abstract class DetailPageState {}
class DetailPageInitial extends DetailPageState {}
class DetailPageLoaded extends DetailPageState {
  final Item item;
  DetailPageLoaded(this.item);
}

// BLoC Implementation
class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  DetailPageBloc() : super(DetailPageInitial());

  @override
  Stream<DetailPageState> mapEventToState(DetailPageEvent event) async* {
    if (event is LoadItemDetails) {
      yield DetailPageLoaded(event.item);
    }
  }
}
