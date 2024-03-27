import 'package:app/constants.dart';
import 'package:app/cubit/open_files/open_files_cubit.dart';
import 'package:app/models/media_files_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/files/tab_bar_files_list_tile_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarFielsListTile extends StatelessWidget {
  const TabBarFielsListTile(
      {super.key,
      required this.size,
      required this.mediaFiles,
      required this.roundedFileSize});

  final Size size;
  final MediaFilesModel mediaFiles;
  final String roundedFileSize;

  @override
  Widget build(BuildContext context) {
    var openFile = context.read<OpenFilesCubit>();
    return ListTile(
      onTap: () async {
        await openFile.openFile(
            fileUrl: mediaFiles.messageFile!,
            fileName: mediaFiles.messageFileName!);
      },
      leading: Icon(FontAwesomeIcons.solidFilePdf,
          color: kPrimaryColor, size: size.height * .03),
      title: Text(mediaFiles.messageFileName!,
          style:
              TextStyle(color: Colors.black87, fontSize: size.height * .018)),
      subtitle: TabBarFilesListTileSubTitle(
          roundedFileSize: roundedFileSize, mediaFiels: mediaFiles),
    );
  }
}
