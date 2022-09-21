import 'package:mscoffeeapp/helpers/is_debug.dart';
import 'package:mscoffeeapp/models/auth0_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../helpers/constants.dart';

/// -----------------------------------
///  DEfine STREAM_API_KEY
/// -----------------------------------

/// -----------------------------------
///  Chat Service Singleton
/// -----------------------------------
class ChatService {
  static final ChatService instance = ChatService._internal();

  factory ChatService() {
    return instance;
  }

  ChatService._internal();
  String? currentChannelId;

  /// -----------------------------------
  ///  1- Chat Client
  /// -----------------------------------
  final client = StreamChatClient(
    STREAM_API_KEY,
    logLevel: isInDebugMode ? Level.INFO : Level.OFF,
  );

  /// -----------------------------------
  ///  2- disconnect
  /// -----------------------------------

  /// -----------------------------------
  ///  3- connectUser
  /// -----------------------------------
  Future<Auth0User> connectUser(Auth0User user) async {
    client.connectUser(
      User(
        id: user.id,
        extraData: {
          'image': user.picture,
          'name': user.name,
        },
      ),
      // Replace it with Production token
      //client.devToken(user.id).rawValue,
      user.chatStreamUserToken!,
    );

    return user;
  }

  /// -----------------------------------
  ///  4- shouldCreateChat
  /// -----------------------------------

  /// -----------------------------------
  ///  5- shouldReconnectChat
  /// -----------------------------------

  /// -----------------------------------
  ///  6- createSupportChat
  /// -----------------------------------
  Future<Channel> createSupportChat() async {
    const staffMember = 'auth062c552b7c3ef56a1d93a935e';
    final channel = client.channel(
      'support',
      extraData: {
        'name':'MSCoffee Support',
        'members':[
          staffMember,
          client.state.currentUser!.id,
        ],
      },
    );


    currentChannelId = channel.id;
    await channel.watch();
    return channel;
  }

  /// -----------------------------------
  ///  7- createCommunityChat
  /// -----------------------------------

}
