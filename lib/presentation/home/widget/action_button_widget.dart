import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app/router/app_router.dart';
import '../../../app/style/app_color.dart';
import '../../../app/style/app_dimens.dart';
import '../../../app/style/gap.dart';
import '../../../app/widget/flutter_popup/flutter_popup.dart';
import '../cubit/handle_tile_cubit.dart';

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
                extra: {"bloc": context.read<HandleTileCubit>()},
              ),
          constraints: BoxConstraints(),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius8),
            ),
            overlayColor: AppColor.customBrown3,
            highlightColor: AppColor.customBrown3.withValues(alpha: 220),
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
          splashColor: AppColor.customBrown3.withValues(alpha: 220),
          highlightColor: AppColor.customBrown3.withValues(alpha: 220),
          hoverColor: AppColor.customBrown3.withValues(alpha: 230),
          borderRadius: BorderRadius.circular(AppDimens.borderRadius8),
          padding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                2,
                (index) => SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.borderRadius4,
                        ),
                      ),
                      overlayColor: AppColor.customBrown2,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.padding16,
                        vertical: AppDimens.padding24,
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
                ),
              ),
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
