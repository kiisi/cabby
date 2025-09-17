import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AppPreferences _appPreference = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    String username =
        "${_appPreference.getUserFirstName()} ${_appPreference.getUserLastName()}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFF6F6F6),
                    minRadius: 30,
                    child: Icon(Icons.person, color: Color(0xFF9E9E9E)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    username,
                    style: const TextStyle(
                        color: Color(0xFF34343A),
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: const ListTile(
                      leading: Icon(
                        Icons.person_outline,
                        color: Color(0xFF6D6C6C),
                      ),
                      title: Text(
                        'Personal info',
                        style: TextStyle(color: Color(0xFF6D6C6C)),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            _divider(),
            SizedBox(
              child: Column(
                children: [
                  InkWell(
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Color(0xFF6D6C6C),
                      ),
                      title: Text(
                        'Log out',
                        style: TextStyle(color: Color(0xFF6D6C6C)),
                      ),
                    ),
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                  ),
                  Material(
                    child: InkWell(
                      child: const ListTile(
                        leading: Icon(
                          Icons.delete_outline,
                          color: Color(0xFF6D6C6C),
                        ),
                        title: Text(
                          'Delete account',
                          style: TextStyle(color: Color(0xFF6D6C6C)),
                        ),
                      ),
                      onTap: () {
                        _showDeleteConfirmationDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  void _showLogoutConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutConfirmationDialog();
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DeleteConfirmationDialog();
      },
    );
  }
}

class LogoutConfirmationDialog extends StatelessWidget {
  LogoutConfirmationDialog({super.key});

  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Dismiss the dialog and return false
          },
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5266),
            foregroundColor: ColorManager.white,
          ),
          onPressed: () async {
            Navigator.of(context).pop(true);
            _appPreferences.logout().then((_) {
              context.router.replaceAll([const AuthenticationRoute()]);
            });
          },
          child: const Text('LOGOUT'),
        ),
      ],
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: const Text('Are you sure you want to delete your account?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Dismiss the dialog and return false
          },
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5266),
            foregroundColor: ColorManager.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
