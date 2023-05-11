import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/utils/prefs.dart';

import 'login_actions.dart';
import '../../utils/consts.dart';
import '../../utils/translator.dart';
import '../../widgets/loading_indicator.dart';
import 'login_bloc.dart';
import 'login_states.dart';

class SartexLogin extends StatelessWidget {
  const SartexLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginBloc(LoginStateStarting()),
        child: _SartexLogin());
  }
}

class _SartexLogin extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginStateLoginComplete) {
                if (prefs.roleWrite('11') || prefs.roleRead('11')) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, route_tv, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, route_dashboard, (route) => false);
                }
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
              return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Column(
                        children: [
                          state is SartexAppStateError
                              ? SizedBox(height: 50, child: Text(state.errorString))
                              : const SizedBox(height: 50),
                          TextFormField(
                            autofocus: true,
                            controller: _emailController,
                            decoration:
                                InputDecoration(labelText: L.tr("Email")),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration:
                                InputDecoration(labelText: L.tr("Password")),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: state is LoginStateLoading
                                  ? const SartexLoadingIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context)
                                            .mapEventToState(LoginActionAuth(
                                                _emailController.text.trim(),
                                                _passwordController.text
                                                    .trim()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 12,
                                          backgroundColor: Colors.blue),
                                      child: Text(L.tr("Login"))))
                        ],
                      )));
            })));
  }
}
