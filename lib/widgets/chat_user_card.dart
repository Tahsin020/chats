import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats/helper/date.dart';
import 'package:chats/views/chat_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import 'dialogs/profile_dialog.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatView(user: widget.user)));
          },
          child: StreamBuilder(
            stream: API.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];
              return ListTile(
                leading: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => ProfileDialog(user: widget.user));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * .055,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                ),
                title: _userName(),
                subtitle: _lastMessage(),
                trailing: _message == null
                    ? null 
                    : _message!.read.isEmpty &&
                            _message!.fromId != API.user.uid
                        ?
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        :
                        Text(
                            Dateutil.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.transparent),
                          ),
              );
            },
          )),
    );
  }

  Text _lastMessage() {
    return Text(
                  _message != null
                      ? _message!.type == Type.image
                          ? 'image'
                          : _message!.msg
                      : widget.user.about,
                  maxLines: 1);
  }

  Text _userName() => Text(widget.user.name);
}
