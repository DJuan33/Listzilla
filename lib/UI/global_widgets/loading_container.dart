import 'package:flutter/material.dart';

/// A [Container] with a [CircularProgressIndicator] inside.
class ListzillaLoading extends StatelessWidget {
  const ListzillaLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
