import 'package:flutter/cupertino.dart';

abstract class EditWidget extends StatelessWidget {
  const EditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  void save(BuildContext context, dynamic object);
}
