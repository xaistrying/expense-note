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
    CardDataModel card = CardDataModel(name: name, price: price);
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
        ),
      ),
    );
  }

  void deleteCard(CardDataModel card) {
    var listCards = [...state.data.listCards];
    listCards.remove(card);
    emit(ListCardsChanged(state.data.copyWith(listCards: listCards)));
  }

  void updateListCard({required List<CardDataModel> listCards}) {
    emit(ListCardsChanged(state.data.copyWith(listCards: listCards)));
  }
}

enum UpdateValueType { add, minus }
