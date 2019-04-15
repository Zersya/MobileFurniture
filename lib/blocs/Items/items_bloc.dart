import 'package:bloc/bloc.dart';
import 'package:furniture_app/models/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:furniture_app/models/item.dart';
import 'items_state.dart';
import 'items_event.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final url = 'https://harpah-app.herokuapp.com/';

  @override
  // TODO: implement initialState
  ItemsState get initialState => ItemsInitial();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    yield ItemsLoading();

    if (event is LoadItems) {
      yield* _loadItems(url + 'api/customer/', event);
    }

    if (event is SelectDetailItem) {
      yield LoadedDetailItem(event.item);
    }

    print(event);
    print(currentState);
  }

  Stream<ItemsState> _loadItems(url, event) async* {
    var res = await http.get(url, headers: {'Authorization': event.token});
    if (res.statusCode == 200) {
      List rawData = json.decode(res.body);
      var items = rawData.map<Item>((json) {
        return Item.fromJson(json);
      }).toList();
      yield ItemsLoaded(items);
    } else {
      yield ItemsNotLoaded();
    }
  }

}
