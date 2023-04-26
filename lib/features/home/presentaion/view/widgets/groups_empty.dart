import 'package:flutter/material.dart';

import 'custom_alert.dart';

class GroupsEmptyWidget extends StatelessWidget {
  const GroupsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 70,
            icon: const Icon(
              Icons.add_box_outlined,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertWidget();
                },
              );
            },
          ),
          Text(
            'There is no groups yet.\nClick add to create a new group.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
