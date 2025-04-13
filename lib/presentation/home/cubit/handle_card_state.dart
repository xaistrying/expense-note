part of 'handle_card_cubit.dart';

@freezed
abstract class HandleCardStateData with _$HandleCardStateData {
  const factory HandleCardStateData({
    int? selectedCardIndex,
    @Default(false) bool isEditingEnabled,
    @Default([]) List<CardDataModel> listCards,
  }) = _HandleCardStateData;
}

@freezed
abstract class HandleCardState with _$HandleCardState {
  const factory HandleCardState.initial(HandleCardStateData data) = _Initial;
  const factory HandleCardState.tileSelectionChanged(HandleCardStateData data) =
      TileSelectionChanged;
  const factory HandleCardState.valueUpdating(HandleCardStateData data) =
      ValueUpdating;
  const factory HandleCardState.editingStateChanged(HandleCardStateData data) =
      EditingStateChanged;
  const factory HandleCardState.listCardsChanged(HandleCardStateData data) =
      ListCardsChanged;
}
