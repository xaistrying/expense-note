import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double? vGap;
  final double? hGap;
  const Gap.v32({super.key}) : vGap = 32.0, hGap = 0.0;
  const Gap.v20({super.key}) : vGap = 20.0, hGap = 0.0;
  const Gap.v16({super.key}) : vGap = 16.0, hGap = 0.0;
  const Gap.v12({super.key}) : vGap = 12.0, hGap = 0.0;
  const Gap.v08({super.key}) : vGap = 8.0, hGap = 0.0;
  const Gap.v04({super.key}) : vGap = 4.0, hGap = 0.0;

  const Gap.h20({super.key}) : hGap = 20.0, vGap = 0.0;
  const Gap.h16({super.key}) : hGap = 16.0, vGap = 0.0;
  const Gap.h12({super.key}) : hGap = 12.0, vGap = 0.0;
  const Gap.h08({super.key}) : hGap = 8.0, vGap = 0.0;
  const Gap.h04({super.key}) : hGap = 4.0, vGap = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: vGap, width: hGap);
  }
}
