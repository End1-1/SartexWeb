import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../MainBloc/actions.dart';
import '../../MainBloc/mainbloc.dart';
import '../../MainBloc/states.dart';
import '../../utils/consts.dart';
import '../../utils/translator.dart';
import '../../widgets/loading_indicator.dart';

class SartexLogin extends StatelessWidget {
  const SartexLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MainBloc(SartexAppStateStarting()),
        child: _SartexLogin());
  }
}

class _SartexLogin extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<MainBloc, SartexAppState>(
            listener: (context, state) {
              if (state is SartexAppStateLoginComplete) {
                Navigator.pushNamedAndRemoveUntil(
                    context, route_dashboard, (route) => false);
              }
            },
            child: BlocBuilder<MainBloc, SartexAppState>(
                builder: (context, state) {
              return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Column(
                        children: [
                          state is SartexAppStateError
                              ? SizedBox(height: 50, child: Text(state.errorString!))
                              : const SizedBox(height: 50),
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                InputDecoration(labelText: L.tr("Email")),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration:
                                InputDecoration(labelText: L.tr("Password")),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: state is SartexAppStateLoadingData
                                  ? const SartexLoadingIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<MainBloc>(context)
                                            .mapEventToState(BlocAuth(
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
