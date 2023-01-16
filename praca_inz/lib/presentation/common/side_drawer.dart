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
              authenticated ? 'Witaj $name' : 'Niezalogowano',
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(authenticated ? Icons.logout : Icons.login),
                Text(
                  authenticated ? 'Wyloguj' : LocaleKeys.welcome_Login.tr(),
                ),
              ],
            ),
            onTap: () => onLoginTileTap(),
          ),
          const _AboutLicencesWidget(),
        ],
      ),
    );
  }
}

class _AboutLicencesWidget extends StatelessWidget {
  const _AboutLicencesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: const [
          Icon(Icons.info_outline),
          Text('O aplikacji'),
        ],
      ),
      onTap: () => showAboutDialog(
        applicationIcon: const Icon(Icons.movie_outlined),
        applicationVersion: '1.0.0',
        applicationName: 'Filmy',
        children: [
          const Text(
              'Aplikacja jest aplikacją niekomercyjną non-profit.\nAutor nie ponosi żadnych korzyści materialnych z działania programu.\nŚcieżki do plakatów filmów zostały podane na dole strony konkretnego filmu.'),
          const Text(
              'Wszystkie informacje zostały zaczerpnięte z www.omdbapi.com,\nna podstawie licencji CC BY-NC 4.0'),
        ],
        context: context,
      ),
    );
  }
}
