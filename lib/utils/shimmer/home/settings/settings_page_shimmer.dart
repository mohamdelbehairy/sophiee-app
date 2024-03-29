import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/utils/shimmer/home/settings/settings_page_card_one_shimmer.dart';
import 'package:app/utils/shimmer/home/settings/settings_page_card_two_shimmer.dart';
import 'package:app/widgets/settings/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPageShimmer extends StatelessWidget {
  const SettingsPageShimmer({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return Column(
      children: [
        AppBarSettings(),
        SettingsPageCardOneShimmer(isDark: isDark,size: size),
        SettingsPageCardTwoShimmer(isDark: isDark,size: size),
      ],
    );
  }
}
