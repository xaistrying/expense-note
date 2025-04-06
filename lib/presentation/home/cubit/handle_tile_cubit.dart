import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

  void updateControllers(int length) {
    var controllers = [...state.data.controllers];
    if (controllers.isEmpty) {
      for (int i = 0; i < length; i++) {
        controllers.add(TextEditingController(text: '1'));
      }
    }
    emit(ControllersUpdated(state.data.copyWith(controllers: controllers)));
  }

  void updateValue(UpdateType type) {
    var index = state.data.selectedTileIndex;
    var controllers = [...state.data.controllers];
    if (index != null) {
      if (controllers.length > index) {
        var value = int.tryParse(controllers[index].text);
        if (value != null) {
          switch (type) {
            case UpdateType.add:
              controllers[index].text = (++value).toString();
              break;
            case UpdateType.minus:
              if (value != 0) {
                controllers[index].text = (--value).toString();
              }
              break;
          }
        }
      }
      emit(ValueUpdated(state.data.copyWith(controllers: controllers)));
    }
  }
}

enum UpdateType { add, minus }
