import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app/style/app_color.dart';
import '../../../app/style/app_dimens.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({
    super.key,
    required this.index,
    required this.isEditingEnabled,
  });

  final int index;
  final bool isEditingEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HandleCardCubit, HandleCardState>(
      builder: (context, state) {
        final isSelected = state.data.selectedCardIndex == index;
        final isEditingEnabled = state.data.isEditingEnabled;
        final card = state.data.listCards[index];
        return Theme(
          data: ThemeData(highlightColor: Colors.transparent),
          child: Material(
            color:
                state.data.selectedCardIndex != null
                    ? isSelected
                        ? AppColor.customBrown3
                        : AppColor.lightCustomBrown3
                    : AppColor.customBrown3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
            ),
            child: ListTile(
              onTap:
                  state.data.isEditingEnabled
                      ? () => context
                          .read<HandleCardCubit>()
                          .changeSelectedListCards(card.id ?? '')
                      : () => context
                          .read<HandleCardCubit>()
                          .changeSelectedCard(index),
              onLongPress:
                  state.data.isEditingEnabled
                      ? () {}
                      : () =>
                          context.read<HandleCardCubit>().changeEditingState(),

              // style
              dense: true,
              splashColor: AppColor.customBrown2.withValues(alpha: 200),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.padding16,
                vertical: AppDimens.padding4,
              ),

              // content
              title: Text(
                card.name ?? '',
                style: TextStyle(fontSize: AppDimens.fontSizeDefault),
              ),
              subtitle: Text(
                (card.price ?? 0).toString(),
                style: TextStyle(
                  fontSize: AppDimens.fontSizeDefault,
                  color: AppColor.customBrown1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading:
                  isEditingEnabled
                      ? state.data.selectedListCards.contains(card.id)
                          ? Icon(
                            MingCute.checkbox_fill,
                            color: AppColor.customBrown1,
                            size: AppDimens.iconSize24,
                          )
                          : Icon(
                            MingCute.square_line,
                            color: AppColor.customBrown1,
                            size: AppDimens.iconSize24,
                          )
                      : null,
              trailing:
                  isEditingEnabled
                      ? ReorderableDragStartListener(
                        index: index,
                        child: const Icon(
                          Icons.drag_indicator_rounded,
                          color: AppColor.customBrown1,
                        ),
                      )
                      : SizedBox(
                        width: 80,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: (card.times ?? 0).toString(),
                          ),
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: AppColor.customBrown1,
                          style: TextStyle(
                            fontSize: AppDimens.fontSizeDefault,
                            color: AppColor.customBrown1,
                            fontWeight: FontWeight.bold,
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: AppDimens.padding8,
                              ),
                              child: Icon(
                                MingCute.close_fill,
                                size: AppDimens.iconSize16,
                                color: AppColor.customBrown1,
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(),
                            border: _customInputBorder(),
                            focusedBorder: _customInputBorder(),
                            enabledBorder: _customInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppDimens.padding8,
                            ),
                          ),
                        ),
                      ),
            ),
          ),
        );
      },
    );
  }
}

InputBorder _customInputBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
  borderSide: BorderSide(
    color: AppColor.customBrown1,
    width: AppDimens.borderWidth2,
  ),
);
