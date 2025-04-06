part of 'handle_tile_cubit.dart';

@freezed
abstract class HandleTileStateData with _$HandleTileStateData {
  const factory HandleTileStateData({int? selectedTileIndex}) =
      _HandleTileStateData;
}

@freezed
abstract class HandleTileState with _$HandleTileState {
  const factory HandleTileState.initial(HandleTileStateData data) = _Initial;
  const factory HandleTileState.tileSelectionChanged(HandleTileStateData data) =
      TileSelectionChanged;
}
