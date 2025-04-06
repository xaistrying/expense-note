import 'package:expense_note/app/router/app_router.dart';
import 'package:expense_note/app/style/gap.dart';
import 'package:expense_note/presentation/home/cubit/handle_tile_cubit.dart';
import 'package:expense_note/presentation/home/widget/custom_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../app/style/app_color.dart';
import '../../app/style/app_dimens.dart';
import 'widget/custom_bottom_navbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HandleTileCubit(),
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap.h12(),
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(Icons.menu_rounded),
                );
              },
            ),
            Gap.h12(),
            Text('data', style: TextStyle(fontSize: AppDimens.fontSizeTitle)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.statistic),
            constraints: BoxConstraints(),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(AppColor.customBrown3),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.all(AppDimens.padding8),
              ),
            ),
            icon: Icon(
              MingCute.chart_vertical_line,
              size: AppDimens.iconSize28,
              color: AppColor.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColor.customBrown2,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(28)),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbarWidget(),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.padding4),
              child: CustomTileWidget(index: index),
            ),

        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.padding8,
          vertical: AppDimens.padding16,
        ),
      ),
    );
  }
}
