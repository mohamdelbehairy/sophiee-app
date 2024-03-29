import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/custom_text_no_media_fiels.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/media/tab_bar_media_grid_view.dart';
import 'package:flutter/material.dart';

class TabBarMedia extends StatelessWidget {
  const TabBarMedia({super.key, required this.mediaList, required this.size});
  final GroupGetMediaFilesCubit mediaList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (mediaList.mediaList.isEmpty) {
      return CustomTextNoMediaFiels(
          size: size, text: 'No Media files here yet');
    }
    return TabBarMediaGridView(mediaList: mediaList, size: size);
  }
}
