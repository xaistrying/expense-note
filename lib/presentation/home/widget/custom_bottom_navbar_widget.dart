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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Durations.medium1, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HandleTileCubit, HandleTileState>(
      listener: (context, state) {
        if (state.data.selectedTileIndex != null) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: Theme(
          data: ThemeData(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: AppColor.customBrown2.withValues(alpha: 160),
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: AppColor.customBrown1,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
            ),
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              Padding(
                padding: const EdgeInsets.all(AppDimens.padding4),
                child: NavigationDestination(
                  icon: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Icon(
                      MingCute.add_fill,
                      color: AppColor.customBrown3,
                    ),
                  ),
                  label: '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.padding4),
                child: NavigationDestination(
                  icon: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Icon(
                      MingCute.minimize_fill,
                      color: AppColor.customBrown3,
                    ),
                  ),
                  label: '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
