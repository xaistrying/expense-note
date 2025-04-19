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

class _CustomBottomNavbarWidgetState extends State<CustomBottomNavbarWidget>
    with TickerProviderStateMixin {
  StatefulNavigationShell get _navigationShell => widget.navigationShell;

  late AnimationController _controller;
  late AnimationController _editcontroller;

  late Animation<Offset> _funcSlideAnimation;
  late Animation<Offset> _navSlideAnimation;
  late Animation<Offset> _editUpSlideAnimation;
  late Animation<Offset> _editDownSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Durations.medium4, vsync: this);
    _editcontroller = AnimationController(
      duration: Durations.medium4,
      vsync: this,
    );

    _funcSlideAnimation = Tween<Offset>(
      begin: Offset(0, 2),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _navSlideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _editUpSlideAnimation = Tween<Offset>(
      begin: Offset(0, 2),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _editcontroller, curve: Curves.easeInOut),
    );
    _editDownSlideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 2),
    ).animate(
      CurvedAnimation(parent: _editcontroller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _editcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HandleCardCubit, HandleCardState>(
      listener: (context, state) {
        if (state.data.selectedCardIndex != null) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        if (state is EditingStateChanged) {
          if (_editcontroller.isForwardOrCompleted) {
            _editcontroller.reverse();
          } else {
            _editcontroller.forward();
          }
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(color: AppColor.customBrown1),
        child: Stack(
          children: [_buildNav(), _buildFunction(), _buildEditFunction()],
        ),
      ),
    );
  }

  Widget _buildNav() {
    return BlocBuilder<HandleCardCubit, HandleCardState>(
      builder: (context, state) {
        return SlideTransition(
          position:
              (state.data.isEditingEnabled == true ||
                          _editcontroller.status == AnimationStatus.reverse) &&
                      state.data.selectedCardIndex == null
                  ? _editDownSlideAnimation
                  : _navSlideAnimation,
          child: Row(
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
          ),
        );
      },
    );
  }

  Widget _buildFunction() {
    return BlocBuilder<HandleCardCubit, HandleCardState>(
      builder: (context, state) {
        return SlideTransition(
          position:
              (state.data.isEditingEnabled == true ||
                          _editcontroller.status == AnimationStatus.reverse) &&
                      state.data.selectedCardIndex != null
                  ? _editDownSlideAnimation
                  : _funcSlideAnimation,
          child: Row(
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
                        () => context.read<HandleCardCubit>().updateValue(
                          UpdateValueType.add,
                        ),
                    iconData: MingCute.add_fill,
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
                    onPressed:
                        () => context.read<HandleCardCubit>().updateValue(
                          UpdateValueType.minus,
                        ),
                    iconData: MingCute.minimize_fill,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditFunction() {
    return SlideTransition(
      position: _editUpSlideAnimation,
      child: Row(
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
                    () => context.read<HandleCardCubit>().updateValue(
                      UpdateValueType.add,
                    ),
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
                onPressed:
                    () => context.read<HandleCardCubit>().updateValue(
                      UpdateValueType.minus,
                    ),
                iconData: MingCute.delete_2_fill,
              ),
            ),
          ),
        ],
      ),
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
