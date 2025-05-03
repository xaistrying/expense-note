import 'package:bloc/bloc.dart';
import 'package:expense_note/domain/model/card_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'handle_card_state.dart';
part 'handle_card_cubit.freezed.dart';

class HandleCardCubit extends Cubit<HandleCardState> {
  HandleCardCubit() : super(HandleCardState.initial(HandleCardStateData()));

  void changeSelectedCard(int index) {
    if (index == state.data.selectedCardIndex) {
      emit(CardSelectionChanged(state.data.copyWith(selectedCardIndex: null)));
    } else {
      emit(CardSelectionChanged(state.data.copyWith(selectedCardIndex: index)));
    }
  }

  void addNewCard({String? name, num? price}) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    CardDataModel card = CardDataModel(id: id, name: name, price: price);
    var listCards = [...state.data.listCards];
    listCards.add(card);
    emit(ListCardsChanged(state.data.copyWith(listCards: listCards)));
  }

  void updateValue(UpdateValueType type) {
    emit(ValueUpdating(state.data));

    var index = state.data.selectedCardIndex;
    var listCards = [...state.data.listCards];
    if (index != null) {
      if (listCards.length > index) {
        var value = listCards[index].times?.toInt() ?? 0;
        switch (type) {
          case UpdateValueType.add:
            listCards[index].times = ++value;
            break;
          case UpdateValueType.minus:
            if (value != 0) {
              listCards[index].times = --value;
            }
            break;
        }
      }
      emit(ListCardsChanged(state.data.copyWith(listCards: listCards)));
    }
  }

  void changeEditingState() {
    emit(
      EditingStateChanged(
        state.data.copyWith(
          isEditingEnabled: !state.data.isEditingEnabled,
          selectedCardIndex: null,
          selectedListCards: [],
        ),
      ),
    );
  }

  void deleteCards() {
    var listCards = [...state.data.listCards];
    var selectedListCards = [...state.data.selectedListCards];
    for (var item in selectedListCards) {
      listCards.removeWhere((e) => e.id == item);
    }
    if (listCards.isEmpty) {
      emit(
        ListCardsChanged(
          state.data.copyWith(
            listCards: listCards,
            selectedListCards: [],
            isEditingEnabled: !state.data.isEditingEnabled,
          ),
        ),
      );
      return;
    }
    emit(
      ListCardsChanged(
        state.data.copyWith(listCards: listCards, selectedListCards: []),
      ),
    );
  }

  void updateListCard({required List<CardDataModel> listCards}) {
    emit(ListCardsChanged(state.data.copyWith(listCards: listCards)));
  }

  void changeSelectedListCards(String id) {
    var selectedListCards = [...state.data.selectedListCards];
    if (selectedListCards.contains(id)) {
      selectedListCards.remove(id);
    } else {
      selectedListCards.add(id);
    }
    emit(
      SelectedListCardsChanged(
        state.data.copyWith(selectedListCards: selectedListCards),
      ),
    );
  }
}

enum UpdateValueType { add, minus }
