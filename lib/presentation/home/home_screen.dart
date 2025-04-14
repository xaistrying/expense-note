import 'package:expense_note/domain/model/card_data_model.dart';
import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:expense_note/presentation/home/widget/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/style/app_dimens.dart';
import 'widget/action_button_widget.dart';
import 'widget/cached_reorder_list_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppDimens.padding16,
        title: Text(
          'data',
          style: TextStyle(fontSize: AppDimens.fontSizeTitle),
        ),
        actions: [ActionButtonWidget()],
      ),
      body: BlocBuilder<HandleCardCubit, HandleCardState>(
        builder: (context, state) {
          final listCards = state.data.listCards;
          return CachedReorderableListView(
            onUpdate: (List<CardDataModel> list) {
              context.read<HandleCardCubit>().updateListCard(listCards: list);
            },
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding8,
              vertical: AppDimens.padding16,
            ),
            list: listCards,
            itemBuilder: (context, item) {
              return Padding(
                key: Key(listCards.indexOf(item).toString()),
                padding: const EdgeInsets.only(bottom: AppDimens.padding8),
                child: CustomCardWidget(
                  index: listCards.indexOf(item),
                  isEditingEnabled: state.data.isEditingEnabled,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
