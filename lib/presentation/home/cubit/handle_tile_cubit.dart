import 'package:bloc/bloc.dart';
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
}
