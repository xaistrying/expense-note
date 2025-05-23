part of 'handle_card_cubit.dart';

@freezed
abstract class HandleCardStateData with _$HandleCardStateData {
  const factory HandleCardStateData({
    int? selectedCardIndex,
    @Default(false) bool isEditingEnabled,
    @Default([]) List<CardDataModel> listCards,
    @Default([]) List<String> selectedListCards,
  }) = _HandleCardStateData;
}

@freezed
abstract class HandleCardState with _$HandleCardState {
  const factory HandleCardState.initial(HandleCardStateData data) = _Initial;
  const factory HandleCardState.cardSelectionChanged(HandleCardStateData data) =
      CardSelectionChanged;
  const factory HandleCardState.valueUpdating(HandleCardStateData data) =
      ValueUpdating;
  const factory HandleCardState.editingStateChanged(HandleCardStateData data) =
      EditingStateChanged;
  const factory HandleCardState.listCardsChanged(HandleCardStateData data) =
      ListCardsChanged;
  const factory HandleCardState.selectedListCardsChanged(
    HandleCardStateData data,
  ) = SelectedListCardsChanged;
}
