import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_item_send_message.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_list_view.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_send_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBodyRefactory extends StatefulWidget {
  const ChatPageBodyRefactory(
      {super.key, required this.user, required this.size});

  final UserModel user;
  final Size size;

  @override
  State<ChatPageBodyRefactory> createState() => _ChatPageBodyRefactoryState();
}

class _ChatPageBodyRefactoryState extends State<ChatPageBodyRefactory> {
  final scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  bool isClick = false;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var message = context.read<MessageCubit>();
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            ChatPageRefacoryListView(
                user: widget.user,
                size: widget.size,
                scrollController: scrollController),
            if (isClick) ChatPageRefactorySendItems(size: widget.size),
            ChatPageRefactoryItemSendMessage(
                onPressed: () {
                  setState(() {
                    isClick = !isClick;
                  });
                },
                textEditingController: textEditingController,
                message: message,
                user: widget.user,
                scrollController: scrollController),
          ],
        );
      },
    );
  }
}
