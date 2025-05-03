import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app/style/app_color.dart';
import '../../../app/style/app_dimens.dart';

class CustomBottomNavbarWidget extends StatefulWidget {
  const CustomBottomNavbarWidget({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<CustomBottomNavbarWidget> createState() =>
      _CustomBottomNavbarWidgetState();
}

class _CustomBottomNavbarWidgetState extends State<CustomBottomNavbarWidget> {
  StatefulNavigationShell get _navigationShell => widget.navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: AppColor.customBrown1),
      child: BlocBuilder<HandleCardCubit, HandleCardState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state.data.isEditingEnabled == false) ...[
                if (state.data.selectedCardIndex == null) ...[
                  _buildNav(),
                ] else ...[
                  _buildFunction(),
                ],
              ] else ...[
                _buildEditFunction(),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildNav() {
    return BlocBuilder<HandleCardCubit, HandleCardState>(
      builder: (context, state) {
        return Row(
          children: [
            // Left
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppDimens.padding4,
                  top: AppDimens.padding4,
                  bottom: AppDimens.padding4,
                  right: AppDimens.padding2,
                ),
                height: double.infinity,
                child: customIconButton(
                  onPressed: () => _navigationShell.goBranch(0),
                  iconData: MingCute.diary_fill,
                  isSelected: _navigationShell.currentIndex == 0,
                ),
              ),
            ),
            // Middle
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppDimens.padding2,
                  top: AppDimens.padding4,
                  bottom: AppDimens.padding4,
                  right: AppDimens.padding2,
                ),
                height: double.infinity,
                child: customIconButton(
                  onPressed: () => _navigationShell.goBranch(1),
                  iconData: MingCute.chart_vertical_fill,
                  isSelected: _navigationShell.currentIndex == 1,
                ),
              ),
            ),
            // Right
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppDimens.padding2,
                  top: AppDimens.padding4,
                  bottom: AppDimens.padding4,
                  right: AppDimens.padding4,
                ),
                height: double.infinity,
                child: customIconButton(
                  onPressed: () => _navigationShell.goBranch(2),
                  iconData: MingCute.settings_4_fill,
                  isSelected: _navigationShell.currentIndex == 2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFunction() {
    return BlocBuilder<HandleCardCubit, HandleCardState>(
      builder: (context, state) {
        return Row(
          children: [
            // Left
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppDimens.padding2,
                  top: AppDimens.padding4,
                  bottom: AppDimens.padding4,
                  right: AppDimens.padding4,
                ),
                height: double.infinity,
                child: customIconButton(
                  onPressed:
                      () => context.read<HandleCardCubit>().updateValue(
                        UpdateValueType.minus,
                      ),
                  iconData: MingCute.minimize_fill,
                ),
              ),
            ),
            // Right
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppDimens.padding4,
                  top: AppDimens.padding4,
                  bottom: AppDimens.padding4,
                  right: AppDimens.padding2,
                ),
                height: double.infinity,
                child: customIconButton(
                  onPressed:
                      () => context.read<HandleCardCubit>().updateValue(
                        UpdateValueType.add,
                      ),
                  iconData: MingCute.add_fill,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditFunction() {
    return Row(
      children: [
        // Left
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: AppDimens.padding4,
              top: AppDimens.padding4,
              bottom: AppDimens.padding4,
              right: AppDimens.padding2,
            ),
            height: double.infinity,
            child: customIconButton(
              onPressed:
                  () => context.read<HandleCardCubit>().changeEditingState(),
              iconData: MingCute.close_fill,
            ),
          ),
        ),
        // Right
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: AppDimens.padding2,
              top: AppDimens.padding4,
              bottom: AppDimens.padding4,
              right: AppDimens.padding4,
            ),
            height: double.infinity,
            child: customIconButton(
              onPressed: () => context.read<HandleCardCubit>().deleteCards(),
              iconData: MingCute.delete_2_fill,
            ),
          ),
        ),
      ],
    );
  }
}

Widget customIconButton({
  required VoidCallback onPressed,
  required IconData iconData,
  bool isSelected = false,
}) => IconButton(
  onPressed: onPressed,
  style: isSelected ? _customSelectedButtonStyle() : _customButtonStyle(),
  icon: Icon(iconData),
);

ButtonStyle _customButtonStyle() => IconButton.styleFrom(
  backgroundColor: Colors.transparent,
  foregroundColor: AppColor.customBrown3,
  focusColor: Colors.transparent,
  hoverColor: Colors.transparent,
  overlayColor: AppColor.customBrown3,
  iconSize: AppDimens.iconSize28,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
  ),
);

ButtonStyle _customSelectedButtonStyle() => IconButton.styleFrom(
  backgroundColor: AppColor.customBrown2.withAlpha(40),
  foregroundColor: AppColor.customBrown3,
  focusColor: Colors.transparent,
  hoverColor: Colors.transparent,
  overlayColor: AppColor.customBrown3,
  iconSize: AppDimens.iconSize28,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
    side: BorderSide(
      color: AppColor.customBrown2,
      width: AppDimens.borderWidth2,
    ),
  ),
);
