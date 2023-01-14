import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats/helper/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/chat_user.dart';

//view profile screen -- to view profile of user
class ViewProfileView extends StatefulWidget {
  final ChatUser user;

  const ViewProfileView({super.key, required this.user});
  @override
  State<ViewProfileView> createState() => _ViewProfileViewState();
}

class _ViewProfileViewState extends State<ViewProfileView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(title: Text(widget.user.name,style: TextStyle(
            color: Theme.of(context).colorScheme.primary
          ),)),
          floatingActionButton: //user about
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Katıldığı Tarih: ',
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(Dateutil.getLastMessageTime(context: context, time: widget.user.createdAt, showYear: true),
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15)),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: mq.width, height: mq.height * .03),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.cover,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                  SizedBox(height: mq.height * .03),
                  Text(widget.user.email, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16)),
                  SizedBox(height: mq.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hakkında: ',
                        style:
                            TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(widget.user.about, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
