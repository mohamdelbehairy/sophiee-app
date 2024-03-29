import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/utils/shimmer/home/all_chats/calls/calls_page_shimmer.dart';
import 'package:app/widgets/all_chats_page/calls_page/calls_page_body.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ConnectivityCubit, ConnectivityResult>(
        builder: (context, state) {
          if (state == ConnectivityResult.wifi ||
              state == ConnectivityResult.mobile) {
            return CallsPageBody(isDark: isDark);
          } else {
            return CallsPageShimmer(size: size,isDark: isDark);
          }
        },
      ),
    );
  }
}
