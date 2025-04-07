import 'package:expense_note/app/router/app_router.dart';
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

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppDimens.padding16,
        title: Text(
          'data',
          style: TextStyle(fontSize: AppDimens.fontSizeTitle),
        ),
        actions: [
          IconButton(
            onPressed:
                () => context.push(
                  AppRouter.newCard,
                  extra: {"bloc": context.read<HandleTileCubit>()},
                ),
            constraints: BoxConstraints(),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(AppColor.customBrown3),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.all(AppDimens.padding4),
              ),
            ),
            icon: Icon(
              MingCute.add_fill,
              size: AppDimens.iconSize24,
              color: AppColor.customBrown1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavbarWidget(),
      body: BlocBuilder<HandleTileCubit, HandleTileState>(
        builder: (context, state) {
          final tiles = state.data.tiles;
          return ListView.builder(
            itemCount: tiles.length,
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.padding4),
                  child: CustomTileWidget(index: index),
                ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding8,
              vertical: AppDimens.padding16,
            ),
          );
        },
      ),
    );
  }
}
