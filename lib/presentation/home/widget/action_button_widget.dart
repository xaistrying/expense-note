import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app/router/app_router.dart';
import '../../../app/style/app_color.dart';
import '../../../app/style/app_dimens.dart';
import '../../../app/style/gap.dart';
import '../../../app/widget/flutter_popup/flutter_popup.dart';
import '../cubit/handle_card_cubit.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Add button
        IconButton(
          onPressed:
              () => context.push(
                AppRouter.newCard,
                extra: {"bloc": context.read<HandleCardCubit>()},
              ),
          constraints: BoxConstraints(),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius8),
            ),
            overlayColor: AppColor.customBrown3.withAlpha(40),
            highlightColor: AppColor.customBrown3.withValues(alpha: 210),
          ),
          icon: Icon(
            MingCute.add_fill,
            size: AppDimens.iconSize24,
            color: AppColor.customBrown3,
          ),
        ),
        Gap.h04(),

        // More button
        CustomPopup(
          backgroundColor: AppColor.customBrown3,
          arrowColor: AppColor.customBrown3,
          barrierColor: Colors.transparent,
          splashColor: AppColor.customBrown3.withAlpha(40),
          highlightColor: AppColor.customBrown3.withAlpha(40),
          hoverColor: AppColor.customBrown3.withAlpha(40),
          borderRadius: BorderRadius.circular(AppDimens.borderRadius8),
          padding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shadowColor: AppColor.customBrown1,
          content: SizedBox(
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _customMenuItem(
                  onPressed: () {
                    context.pop();
                    context.read<HandleCardCubit>().changeEditingState();
                  },
                ),
                _customMenuItem(
                  onPressed: () {
                    context.pop();
                    context.read<HandleCardCubit>().changeEditingState();
                  },
                ),
              ],
            ),
          ),
          child: Icon(
            MingCute.more_2_fill,
            size: AppDimens.iconSize24,
            color: AppColor.customBrown3,
          ),
        ),
      ],
    );
  }
}

Widget _customMenuItem({required VoidCallback onPressed}) => SizedBox(
  width: double.infinity,
  child: TextButton(
    onPressed: onPressed,
    style: IconButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
      ),
      overlayColor: AppColor.customBrown2,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.padding16,
        vertical: AppDimens.padding12,
      ),
      alignment: Alignment.centerLeft,
    ),
    child: Text(
      'data',
      style: TextStyle(
        fontSize: AppDimens.fontSizeDefault,
        color: AppColor.black,
      ),
    ),
  ),
);
