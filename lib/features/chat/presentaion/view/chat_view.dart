import 'package:chatia/core/utils/cache_helper.dart';
import 'package:chatia/core/utils/constants.dart';
import 'package:chatia/core/utils/routers.dart';
import 'package:chatia/features/home/data/group_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.model});
  final GroupModel model;

  var name = CacheHelper.getData(key: fullNameKey);
  var email = CacheHelper.getData(key: emailKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          model.groupName,
        ),
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.chatInfoView, extra: model);
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.groupId,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
