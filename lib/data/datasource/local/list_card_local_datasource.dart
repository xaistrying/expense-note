import 'dart:convert';

import 'package:expense_note/app/service/app_prefs_service_helper.dart';

import '../../../app/di/injector.dart';
import '../../../domain/model/card_data_model.dart';

const cachedListCard = 'CACHED_LIST_CARD';

abstract class ListCardLocalDatasource {
  List<CardDataModel> getLocalListCard();
  Future setLocalCard({required CardDataModel card});
  Future removeLocalCard({required CardDataModel card});
  Future removeAllLocalListCard();
}

class ListCardLocalDatasourceImpl implements ListCardLocalDatasource {
  final _pref = getIt<AppPrefsServiceHelper>();

  @override
  List<CardDataModel> getLocalListCard() {
    final jsonData = _pref.getValue(cachedListCard);
    List<CardDataModel> listCard = [];

    if (jsonData != null) {
      listCard = CardDataModel.fromList(json.decode(jsonData));
    }
    return listCard;
  }

  @override
  Future setLocalCard({required CardDataModel card}) async {
    String? jsonData = _pref.getValue(cachedListCard);

    if (jsonData != null && jsonData != '[]') {
      List<CardDataModel> listCard = CardDataModel.fromList(
        json.decode(jsonData),
      );
      final index = listCard.indexWhere((e) => e.id == card.id);

      if (index == -1) {
        listCard.add(card);
      } else {
        listCard[index] = card;
      }

      await _pref.setValue(
        cachedListCard,
        json.encode(listCard.map((e) => e.toJson()).toList()),
      );
    } else {
      List<CardDataModel> listCard = [card];

      await _pref.setValue(
        cachedListCard,
        json.encode(listCard.map((e) => e.toJson()).toList()),
      );
    }
  }

  @override
  Future removeLocalCard({required CardDataModel card}) async {
    String? jsonData = _pref.getValue(cachedListCard);

    if (jsonData != null && jsonData != '[]') {
      List<CardDataModel> listCard = CardDataModel.fromList(
        json.decode(jsonData),
      );
      final index = listCard.indexWhere((e) => e.id == card.id);

      if (index != -1) {
        listCard.removeAt(index);
      }

      await _pref.setValue(
        cachedListCard,
        json.encode(listCard.map((e) => e.toJson()).toList()),
      );
    }
  }

  @override
  Future removeAllLocalListCard() async {
    await _pref.removeValue(cachedListCard);
  }
}
