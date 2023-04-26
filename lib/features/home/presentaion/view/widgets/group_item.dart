import 'package:chatia/core/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/styles/app_color.dart';
import '../../../data/group_model.dart';

class GroupItemBuilder extends StatelessWidget {
  const GroupItemBuilder({
    super.key,
    required this.groupName,
    required this.recentMsg,
    required this.model,
  });
  final String groupName;
  final String recentMsg;
  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.chatView, extra: model);
      },
      child: ListTile(
        leading: const CircleAvatar(
            backgroundColor: ColorManager.darkCardColor,
            child: Icon(Icons.group)),
        title: Text(
          groupName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          recentMsg,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
