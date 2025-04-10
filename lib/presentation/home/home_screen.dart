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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
              ),
              overlayColor: AppColor.customBrown3,
              highlightColor: AppColor.customBrown3.withValues(alpha: 220),
              tapTargetSize: MaterialTapTargetSize.padded,
            ),
            icon: Icon(
              MingCute.add_fill,
              size: AppDimens.iconSize24,
              color: AppColor.customBrown3,
            ),
          ),
          Gap.h08(),
          IconButton(
            onPressed: () {},
            constraints: BoxConstraints(),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
              ),
              overlayColor: AppColor.customBrown3,
              highlightColor: AppColor.customBrown3.withValues(alpha: 220),
              tapTargetSize: MaterialTapTargetSize.padded,
            ),
            icon: Icon(
              MingCute.more_2_fill,
              size: AppDimens.iconSize24,
              color: AppColor.customBrown3,
            ),
          ),
        ],
      ),
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
