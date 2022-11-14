import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/presentation/authorization/cubit/authorization_cubit.dart';


class AuthorizationPage extends HookWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<AuthorizationCubit>();
    final state = useBlocBuilder(cubit);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: state.maybeMap(
          authenticated: (value) => [
            const Text('autoryzowano'),
            TextButton(
              onPressed: () => cubit.signOutRequested(),
              child: const Text('sign out'),
            )
          ],
          authError: (value) => [
            const Text('blad'),
          ],
          orElse: () => [
            const Text('inne stany'),
            TextButton(
              onPressed: () => cubit.googleSignInRequested(),
              child: const Text('google sign in'),
            ),
            // TextButton(
            //   onPressed: () => cubit.signInRequested(),
            //   child: const Text('google sign in'),
            // ),
          ],
        ),
      ),
    );
  }
}
