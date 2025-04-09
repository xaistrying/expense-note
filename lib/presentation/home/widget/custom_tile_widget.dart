import 'package:expense_note/presentation/home/cubit/handle_tile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app/style/app_color.dart';
import '../../../app/style/app_dimens.dart';

class CustomTileWidget extends StatelessWidget {
  const CustomTileWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HandleTileCubit, HandleTileState>(
      builder: (context, state) {
        final isSelected = state.data.selectedTileIndex == index;
        final tile = state.data.tiles[index];
        return Theme(
          data: ThemeData(highlightColor: Colors.transparent),
          child: Material(
            color: AppColor.customBrown3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
              side:
                  isSelected
                      ? BorderSide(
                        color: AppColor.customBrown1,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      )
                      : BorderSide.none,
            ),
            child: ListTile(
              dense: true,
              splashColor: AppColor.customBrown2.withValues(alpha: 200),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.padding16,
                vertical: AppDimens.padding4,
              ),
              title: Text(
                tile.name ?? '',
                style: TextStyle(fontSize: AppDimens.fontSizeDefault),
              ),
              subtitle: Text(
                (tile.price ?? 0).toString(),
                style: TextStyle(
                  fontSize: AppDimens.fontSizeDefault,
                  color: AppColor.customBrown1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:
                  () =>
                      context.read<HandleTileCubit>().changeSelectedTile(index),
              trailing: SizedBox(
                width: 80,
                child: TextFormField(
                  controller: TextEditingController(
                    text: (tile.times ?? 0).toString(),
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
                      padding: const EdgeInsets.only(left: AppDimens.padding8),
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
