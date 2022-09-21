// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mscoffeeapp/services/auth_service.dart';
import 'package:mscoffeeapp/services/chat_service.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../models/auth0_permission.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String? availableCustomerServiceId;
  Channel? channel;

  @override
  void initState() {
    super.initState();

    createChannel();

    /// -----------------------------------
    ///  getProfile from auth service
    /// -----------------------------------

    /// -----------------------------------
    /// get an available customer service agent
    /// -----------------------------------
  }

  createChannel() async {
    channel = await ChatService.instance.createSupportChat();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return channel == null
        ? const Center(
            child: Text('You are int he queue!, please wait...'),
          )

        /// -----------------------------------
        /// implement chat
        /// -----------------------------------
        : Scaffold(
            body: StreamChannel(
            channel: channel!,
            child: Column(
              children: [
                const Expanded(
                  child: StreamMessageListView(),
                ),
                StreamMessageInput(
                  disableAttachments: !AuthService.instance.user!.can(
                    Permission.upload,
                  ),
                  sendButtonLocation: SendButtonLocation.inside,
                  actionsLocation: ActionsLocation.leftInside,
                  showCommandsButton: !AuthService.instance.user!.isTWSUser,
                ),
              ],
            ),
          ));
  }
}
