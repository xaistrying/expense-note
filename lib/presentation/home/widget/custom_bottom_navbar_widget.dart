import 'package:expense_note/presentation/home/cubit/handle_tile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app/style/app_color.dart';
import '../../../app/style/app_dimens.dart';

class CustomBottomNavbarWidget extends StatefulWidget {
  const CustomBottomNavbarWidget({super.key});

  @override
  State<CustomBottomNavbarWidget> createState() =>
      _CustomBottomNavbarWidgetState();
}

class _CustomBottomNavbarWidgetState extends State<CustomBottomNavbarWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  late AnimationController _navController;
  late Animation<Offset> _navSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Durations.medium1, vsync: this);
    _navController = AnimationController(
      duration: Durations.medium1,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _navSlideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 1),
    ).animate(CurvedAnimation(parent: _navController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _navController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HandleTileCubit, HandleTileState>(
      listener: (context, state) {
        if (state.data.selectedTileIndex != null) {
          _navController.forward();
          Future.delayed(Durations.medium1, () {
            _controller.forward();
          });
        } else {
          _controller.reverse();
          Future.delayed(Durations.medium1, () {
            _navController.reverse();
          });
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(color: AppColor.customBrown1),
        child: Stack(
          children: [
            // Nav
            SlideTransition(
              position: _navSlideAnimation,
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
                      child: IconButton(
                        onPressed:
                            () => context.read<HandleTileCubit>().updateValue(
                              UpdateValueType.add,
                            ),
                        style: _customButtonStyle(),
                        icon: Icon(MingCute.diary_fill),
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
                      child: IconButton(
                        onPressed:
                            () => context.read<HandleTileCubit>().updateValue(
                              UpdateValueType.add,
                            ),
                        style: _customButtonStyle(),
                        icon: Icon(MingCute.chart_vertical_fill),
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
                      child: IconButton(
                        onPressed:
                            () => context.read<HandleTileCubit>().updateValue(
                              UpdateValueType.add,
                            ),
                        style: _customButtonStyle(),
                        icon: Icon(MingCute.settings_4_fill),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Function
            SlideTransition(
              position: _slideAnimation,
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
                      child: IconButton(
                        onPressed:
                            () => context.read<HandleTileCubit>().updateValue(
                              UpdateValueType.add,
                            ),
                        style: _customButtonStyle(),
                        icon: Icon(MingCute.add_fill),
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
                      child: IconButton(
                        onPressed:
                            () => context.read<HandleTileCubit>().updateValue(
                              UpdateValueType.minus,
                            ),
                        style: _customButtonStyle(),
                        icon: Icon(MingCute.minimize_fill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
