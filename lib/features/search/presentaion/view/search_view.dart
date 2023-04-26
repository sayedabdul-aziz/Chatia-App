import 'package:chatia/core/utils/extensions.dart';
import 'package:chatia/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../view_model/cubit/search_cubit.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Searching by group name ..',
                      ),
                      onFieldSubmitted: (value) async {
                        await cubit.searchByName(value);
                      },
                    ),
                  ),
                  20.pw,
                  GestureDetector(
                    onTap: () async {
                      await cubit.searchByName(searchController.text);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorManager.primaryColor),
                      child: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: ColorManager.greyColor,
                      ),
                    ),
                  )
                ],
              ),
              20.ph,
              const Text('Search Results : '),
              10.ph,
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const CustomCircularProgressIndicator();
                  } else if (state is SearchSuccessState) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var data = cubit.groups!.docs[index];

                          return FutureBuilder(
                            future: DatabaseServices()
                                .isUserJoined(data['groupName']),
                            initialData: false,
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return ListTile(
                                leading: const CircleAvatar(
                                    backgroundColor: ColorManager.darkCardColor,
                                    child: Icon(Icons.group)),
                                title: Text(
                                  data['groupName'],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                trailing: snapshot.data ?? false
                                    ? Container(
                                        child: const Text('Joined'),
                                      )
                                    : Container(
                                        child: const Text('Join'),
                                      ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: cubit.groups!.docs.length,
                      ),
                    );
                  } else {
                    return const Text('errror');
                  }
                },
              )
            ],
          ),
        ));
  }
}
