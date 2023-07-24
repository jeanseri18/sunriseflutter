import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 80,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SpinKitThreeBounce(
            color: Colors.black,
            size: 35.0,
          )),
    );
  }
}
