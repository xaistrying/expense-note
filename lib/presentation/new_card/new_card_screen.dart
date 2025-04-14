import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/style/app_color.dart';
import '../../app/style/app_dimens.dart';
import '../../app/style/gap.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    priceTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'data',
          style: TextStyle(fontSize: AppDimens.fontSizeTitle),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.padding16,
          vertical: AppDimens.padding16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customTitleWithTextField(nameTextController),
            Gap.v20(),
            _customTitleWithTextField(priceTextController),
            Spacer(),
            _customCreateCardButton(() {
              context.read<HandleCardCubit>().addNewCard(
                name: nameTextController.text,
                price: num.tryParse(priceTextController.text),
              );
              context.pop();
            }),
          ],
        ),
      ),
    );
  }

  Widget _customTitleWithTextField(TextEditingController controller) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'data',
        style: TextStyle(
          fontSize: AppDimens.fontSizeDefault,
          color: AppColor.customBrown1,
          fontWeight: FontWeight.bold,
        ),
      ),
      Gap.v08(),
      TextFormField(
        controller: controller,
        cursorColor: AppColor.customBrown1,
        style: TextStyle(
          fontSize: AppDimens.fontSizeDefault,
          color: AppColor.black,
        ),
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(AppDimens.padding16),
          filled: true,
          fillColor: AppColor.customBrown3,
          hoverColor: AppColor.customBrown3,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.borderRadius4),
            borderSide: BorderSide(
              color: AppColor.customBrown1,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      ),
    ],
  );

  Widget _customCreateCardButton(VoidCallback onPressed) => SizedBox(
    width: double.infinity,
    child: TextButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: AppColor.customBrown1,
        foregroundColor: AppColor.customBrown3,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        overlayColor: AppColor.customBrown3,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.padding16),
        child: Text(
          'data',
          style: TextStyle(fontSize: AppDimens.fontSizeDefault),
        ),
      ),
    ),
  );
}
