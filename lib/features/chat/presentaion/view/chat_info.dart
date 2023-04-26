import 'package:chatia/core/utils/extensions.dart';
import 'package:chatia/core/widgets/custom_loading_widget.dart';
import 'package:chatia/features/chat/presentaion/view_model/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_color.dart';
import '../../../home/data/group_model.dart';
import '../../../home/presentaion/view/widgets/group_item.dart';
import '../../../home/presentaion/view/widgets/groups_empty.dart';

class ChatInfoView extends StatelessWidget {
  const ChatInfoView({super.key, required this.model});
  final GroupModel model;

  String getMemberName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getMemberId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MessageCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Info',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 120,
            ),
            20.ph,
            Text(
              model.groupName,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            15.ph,
            Text(
              model.groupId,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            15.ph,
            const Divider(),
            15.ph,
            Text(
              'Members',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            15.ph,
            BlocBuilder<MessageCubit, MessageState>(
              builder: (context, state) {
                if (state is GetMembersLoadingState) {
                  return const CustomCircularProgressIndicator();
                } else if (state is GetMembersSuccessState) {
                  return Expanded(
                    child: StreamBuilder(
                      stream: cubit.members,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List data = snapshot.data['members'];
                          if (data.isNotEmpty) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor:
                                          ColorManager.darkCardColor,
                                      child: Icon(Icons.group)),
                                  title: Text(
                                    getMemberName(data[index]),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  subtitle: Text(
                                    getMemberId(data[index]),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  trailing: index == 0
                                      ? const Text('Admin')
                                      : Container(),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: data.length,
                            );
                          } else {
                            return const GroupsEmptyWidget();
                          }
                        } else {
                          return const CustomCircularProgressIndicator();
                        }
                      },
                    ),
                  );
                } else {
                  return const Text('errror');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
