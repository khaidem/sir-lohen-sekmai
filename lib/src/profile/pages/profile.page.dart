import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snp_garbage_collection/src/core/constant/constant.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';
import 'package:snp_garbage_collection/src/core/logic/logic.dart';
import 'package:snp_garbage_collection/src/core/widgets/widgets.dart';
import 'package:snp_garbage_collection/src/profile/logic/profile/profile_cubit.dart';
import 'package:snp_garbage_collection/src/profile/widget/widget.dart';

import '../data/data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AfterLayoutMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: const ProfileView(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ProfileCubit>().fetchProfile();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;

    switch (state.status) {
      case ProfileStatus.initial:
        return const Center(child: CircularProgressIndicator());

      case ProfileStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case ProfileStatus.loaded:
        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () {
                return context.read<ProfileCubit>().fetchProfile();
              },
              child: ListView(
                // shrinkWrap: true,
                children: [
                  UserInfoCardView(profileModel: state.profileModel!),
                  const Divider(),
                  const AppInfo(),
                  const Divider(),
                  const LogoutListButton(),
                  // const SizedBox(height: 200),
                ],
              ),
            ),
            // const Spacer(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: MadeWithLove(),
            ),
          ],
        );
      case ProfileStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${state.errorMessage}",
                textAlign: TextAlign.center,
                style: context.textTheme.subtitle2?.copyWith(
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButtonView(
                onPressed: () {
                  context.read<ProfileCubit>().fetchProfile();
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        );
    }
  }
}

class UserInfoCardView extends StatelessWidget {
  const UserInfoCardView({Key? key, required this.profileModel})
      : super(key: key);

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: FadeInImage.assetNetwork(
            placeholder: KImage.user,
            image: profileModel.photo,
            width: 50,
            height: 50,
          ),
        ),
      ),
      title: Text("${profileModel.firstName} ${profileModel.lastName}"),
      subtitle: Text(profileModel.designation),
    );
  }
}

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final packageInfo = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("Name"),
                trailing: Text("${packageInfo?.appName}"),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("Version"),
                trailing: Text(
                    "${packageInfo?.version} (${packageInfo?.buildNumber})"),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class LogoutListButton extends StatelessWidget {
  const LogoutListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.exit_to_app,
        color: Colors.red,
      ),
      title: const Text("Logout", style: TextStyle(color: Colors.red)),
      onTap: () => context.read<AuthenticationCubit>().logout(),
    );
  }
}
