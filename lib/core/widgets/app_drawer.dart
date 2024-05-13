import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final AppPreferences _appPreference = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes rounded corners
      ),
      child: Container(
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        child: ListView(
          children: [
            _profileHeader(context),
            _divider(),
            DrawerItem(
              icon: Icons.payment,
              onTap: () async {
                await context.router.pushNamed('/payment');
              },
              title: 'Payment',
            ),
            DrawerItem(
              icon: Icons.history,
              onTap: () {},
              title: 'Ride History',
            ),
            DrawerItem(
              icon: Icons.local_offer_outlined,
              onTap: () {},
              title: 'Offer and Coupens',
            ),
            DrawerItem(
              icon: Icons.info_outline_rounded,
              onTap: () {},
              title: 'About',
            ),
            DrawerItem(
              icon: Icons.contact_support_outlined,
              onTap: () {},
              title: 'Support',
            ),
            _divider(),
            DrawerItem(
              icon: Icons.local_taxi,
              onTap: () {},
              title: 'Become a driver',
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    String username =
        "${_appPreference.getUserFirstName()} ${_appPreference.getUserLastName()}";

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 0.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Material(
        child: InkWell(
          onTap: () async {
            await context.router.pushNamed('/profile');
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFF6F6F6),
                  minRadius: 30,
                  child: Icon(Icons.person, color: Color(0xFF9E9E9E)),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          color: Color(0xFF34343A),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      'View profile',
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      color: const Color(0xFFE9EAEC),
      child: Column(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          leading: Icon(icon, color: const Color(0xFF737479)),
          title: Text(
            title,
            style: const TextStyle(color: Color(0xFF737479)),
          ),
        ),
      ),
    );
  }
}
