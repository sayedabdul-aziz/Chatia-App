import 'package:chatia/core/styles/app_color.dart';
import 'package:chatia/core/utils/routers.dart';
import 'package:chatia/core/widgets/custom_drawer_widget.dart';
import 'package:chatia/core/widgets/custom_loading_widget.dart';
import 'package:chatia/features/home/data/group_model.dart';
import 'package:chatia/features/home/presentaion/view/widgets/custom_alert.dart';
import 'package:chatia/features/home/presentaion/view/widgets/group_item.dart';
import 'package:chatia/features/home/presentaion/view/widgets/groups_empty.dart';
import 'package:chatia/features/home/presentaion/view_model/cubit/home_cubit.dart';
import 'package:chatia/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  String getGroupName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getGroupsList(),
      child: Scaffold(
        drawer: CustomDrawerWidget(),
        appBar: AppBar(
          title: const Text(
            'Chats',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.searchView);
                },
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 17,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertWidget();
              },
            );
          },
          backgroundColor: ColorManager.primaryColor,
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GroupsSuccessState) {
              var cubit = HomeCubit.get(context);
              return StreamBuilder(
                stream: cubit.groups,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data['groups'];
                    if (data.isNotEmpty) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: ColorManager.greyColor,
                              child: const Icon(Icons.delete),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              await DatabaseServices(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .deletingGroup(getId(data[index]),
                                      getGroupName(data[index]))
                                  .then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Deleting Successfully..',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                ));
                              });
                            },
                            key: const Key('value'),
                            child: GroupItemBuilder(
                              groupName: getGroupName(data[index]),
                              recentMsg:
                                  'Start Conversion with our members now.',
                              model: GroupModel(
                                getId(data[index]),
                                getGroupName(data[index]),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: data.length,
                      );
                    } else {
                      return const GroupsEmptyWidget();
                    }
                  } else {
                    return const CustomCircularProgressIndicator();
                  }
                },
              );
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}
