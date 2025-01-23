import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media/features/home/presentation/components/my_drawer_tile.dart';
import 'package:social_media/features/profile/presentation/pages/profile_page.dart';
import 'package:social_media/features/search/presentation/pages/search_page.dart';
import 'package:social_media/features/settings/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              Divider(color: Theme.of(context).colorScheme.secondary),

              // home tile
              MyDrawerTile(
                  icon: Icons.home,
                  title: "H O M E",
                  onTap: () => Navigator.of(context).pop()),

              // profile tile
              MyDrawerTile(
                  icon: Icons.person,
                  title: "P R O F I L E",
                  onTap: () {
                    // pop menu drawer
                    Navigator.of(context).pop();

                    // get current user id
                    final user = context.read<AuthCubit>().currentUser;
                    String? uid = user!.uid;
                    // navigate to profile page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  uid: uid,
                                )));
                  }),

// search tile
              MyDrawerTile(
                  icon: Icons.search, title: "S E A R C H", onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage())
                  )),

              // settings tile
              MyDrawerTile(
                  icon: Icons.settings, title: "S E T T I N G S", onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingsPage())
                  )),

              const Spacer(),

              // logout tile
              MyDrawerTile(
                  icon: Icons.login,
                  title: "L O G O U T",
                  onTap: () => context.read<AuthCubit>().logout()),
            ],
          ),
        ),
      ),
    );
  }
}
