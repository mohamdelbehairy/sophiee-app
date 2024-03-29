import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/files/tab_bar_files.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/links/tab_bar_links.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/media/tab_bar_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatMediaFielsPageBody extends StatelessWidget {
  const GroupsChatMediaFielsPageBody(
      {super.key, required this.size, required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var mediaFielsList = context.read<GroupGetMediaFilesCubit>();

    return SafeArea(
        child: BlocBuilder<GroupGetMediaFilesCubit, GroupGetMediaFilesState>(
      builder: (context, state) {
        return Column(children: [
          Expanded(
              child: TabBarView(children: [
            TabBarMedia(mediaList: mediaFielsList, size: size),
            TabBarFiles(filesList: mediaFielsList, size: size),
            TabBarLinks(linksList: mediaFielsList, size: size),
            Text('0'),
            Text('00')
          ]))
        ]);
      },
    ));
  }
}
