import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praca_inzynierska/generated/local_keys.g.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    required this.customTheme,
    required this.authenticated,
    required this.onLoginTileTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  final CustomAppTheme customTheme;
  final bool authenticated;
  final VoidCallback onLoginTileTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: customTheme.primary40,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: customTheme.primary10),
            child: Text(
              authenticated ? 'Hello $name' : 'Unauthenticated',
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(authenticated ? Icons.logout : Icons.login),
                Text(
                  authenticated
                      ? 'Logout'
                      : LocaleKeys.welcome_Login.tr(), //Todo To Json locale
                ),
              ],
            ),
            onTap: () => onLoginTileTap(),
          ),
        ],
      ),
    );
  }
}
