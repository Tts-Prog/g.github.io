import 'package:flutter/material.dart';

class NormalScaffold extends StatelessWidget {
  final bool busy;

  const NormalScaffold({
    super.key,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [if (busy) const CircularProgressIndicator()],
    );
  }
}
