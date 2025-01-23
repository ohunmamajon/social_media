import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/profile/presentation/components/user_tile.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media/responsive/constrained_scaffold.dart';

class FollowerPage extends StatelessWidget {
  final List<String> followers;
  final List<String> following;
  const FollowerPage(
      {super.key, required this.followers, required this.following});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 22,
        child: ConstrainedScaffold(
          appBar: AppBar(
            bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.inversePrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(
                  text: "Followers",
                ),
                Tab(
                  text: "Following",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildUserList(followers, "No followers", context),
              _buildUserList(following, "No following", context)
            ],
          ),
        ));
  }

  // build user list, given list of profile uids
  Widget _buildUserList(
      List<String> uids, String emptyMessage, BuildContext context) {
    return uids.isEmpty
        ? Center(
            child: Text(emptyMessage),
          )
        : ListView.builder(
            itemCount: uids.length,
            itemBuilder: (context, index) {
              final uid = uids[index];

              return FutureBuilder(
                  future: context.read<ProfileCubit>().getUserProfile(uid),
                  builder: (context, snapshot) {
                    // user loaded
                    if (snapshot.hasData) {
                      final user = snapshot.data!;
                      return UserTile(user: user);
                    }

                    // loading...
                    else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const ListTile(
                        title: Text("Loading.."),
                      );
                    }

                    // not found
                    else {
                      return const ListTile(
                        title: Text("User not found.."),
                      );
                    }
                  });
            });
  }
}
