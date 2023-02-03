import 'package:flutter/material.dart';

class RawIndividualMessageWidget extends StatelessWidget {
  const RawIndividualMessageWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
