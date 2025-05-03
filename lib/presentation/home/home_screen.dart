import 'package:expense_note/app/style/gap.dart';
import 'package:expense_note/domain/model/card_data_model.dart';
import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:expense_note/presentation/home/widget/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

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
        title: BlocBuilder<HandleCardCubit, HandleCardState>(
          builder: (context, state) {
            if (state.data.isEditingEnabled) {
              final listCardsLength = state.data.listCards.length;
              final selectedListCardsLength =
                  state.data.selectedListCards.length;
              return Row(
                children: [
                  IconButton(
                    onPressed:
                        () =>
                            context
                                .read<HandleCardCubit>()
                                .changeSelectedListCards(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                    icon:
                        listCardsLength == selectedListCardsLength
                            ? Icon(
                              MingCute.check_circle_fill,
                              size: AppDimens.iconSize24,
                            )
                            : selectedListCardsLength == 0
                            ? Icon(
                              MingCute.round_line,
                              size: AppDimens.iconSize24,
                            )
                            : Icon(
                              MingCute.minus_circle_fill,
                              size: AppDimens.iconSize24,
                            ),
                  ),
                  Gap.h04(),
                  Text(
                    '${state.data.selectedListCards.length} data',
                    style: TextStyle(
                      fontSize: AppDimens.fontSizeTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.padding4,
              ),
              child: Text(
                'data',
                style: TextStyle(
                  fontSize: AppDimens.fontSizeTitle,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
        actions: [
          BlocBuilder<HandleCardCubit, HandleCardState>(
            builder: (context, state) {
              if (state.data.isEditingEnabled) {
                return const SizedBox.shrink();
              }
              return ActionButtonWidget();
            },
          ),
        ],
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
