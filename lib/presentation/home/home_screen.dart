import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:expense_note/presentation/home/widget/custom_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/style/app_dimens.dart';
import 'widget/action_button_widget.dart';

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
        actions: [ActionButtonWidget()],
      ),
      body: BlocBuilder<HandleCardCubit, HandleCardState>(
        builder: (context, state) {
          final tiles = state.data.listCards;
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
