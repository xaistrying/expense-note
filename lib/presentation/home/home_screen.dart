import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:expense_note/presentation/home/widget/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/style/app_dimens.dart';
import 'widget/action_button_widget.dart';

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
          return ReorderableListView.builder(
            buildDefaultDragHandles: false,
            proxyDecorator: (child, index, animation) => child,
            itemCount: listCards.length,
            itemBuilder:
                (context, index) => Padding(
                  key: Key(index.toString()),
                  padding: const EdgeInsets.only(bottom: AppDimens.padding8),
                  child: CustomCardWidget(
                    index: index,
                    isEditingEnabled: state.data.isEditingEnabled,
                  ),
                ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding8,
              vertical: AppDimens.padding16,
            ),
            onReorder: (int oldIndex, int newIndex) {
              var listCardsTempt = [...state.data.listCards];
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final card = listCardsTempt.removeAt(oldIndex);
              listCardsTempt.insert(newIndex, card);
              context.read<HandleCardCubit>().updateListCard(
                listCards: listCardsTempt,
              );
            },
          );
        },
      ),
    );
  }
}
