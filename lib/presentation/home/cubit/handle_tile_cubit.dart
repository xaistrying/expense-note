import 'package:bloc/bloc.dart';
import 'package:expense_note/domain/model/tile_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'handle_tile_state.dart';
part 'handle_tile_cubit.freezed.dart';

class HandleTileCubit extends Cubit<HandleTileState> {
  HandleTileCubit() : super(HandleTileState.initial(HandleTileStateData()));

  void changeSelectedTile(int index) {
    if (index == state.data.selectedTileIndex) {
      emit(TileSelectionChanged(state.data.copyWith(selectedTileIndex: null)));
    } else {
      emit(TileSelectionChanged(state.data.copyWith(selectedTileIndex: index)));
    }
  }

  void updateControllers({String? name, num? price}) {
    TileDataModel tile = TileDataModel(name: name, price: price);
    var tiles = [...state.data.tiles];
    tiles.add(tile);
    emit(ControllersUpdated(state.data.copyWith(tiles: tiles)));
  }

  void updateValue(UpdateValueType type) {
    emit(ValueUpdating(state.data));

    var index = state.data.selectedTileIndex;
    var tiles = [...state.data.tiles];
    if (index != null) {
      if (tiles.length > index) {
        var value = tiles[index].times?.toInt() ?? 0;
        switch (type) {
          case UpdateValueType.add:
            tiles[index].times = ++value;
            break;
          case UpdateValueType.minus:
            if (value != 0) {
              tiles[index].times = --value;
            }
            break;
        }
      }
      emit(ControllersUpdated(state.data.copyWith(tiles: tiles)));
    }
  }
}

enum UpdateValueType { add, minus }
