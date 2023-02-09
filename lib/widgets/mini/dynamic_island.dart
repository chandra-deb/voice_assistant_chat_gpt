import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dynamic_island_provider.dart';

class DynamicIsland extends StatelessWidget {
  const DynamicIsland({super.key});

  @override
  Widget build(BuildContext context) {
    final island = context.watch<DynamicIslandProvider>().island;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: island == Island.copying
          ? const SingleIsland(
              'Copied',
              key: ValueKey(0),
            )
          : island == Island.deleting
              ? const SingleIsland(
                  'Deleted',
                  key: ValueKey(1),
                )
              : island == Island.sharing
                  ? const SingleIsland(
                      'Shared',
                      key: ValueKey(2),
                    )
                  : const SingleIsland(
                      'Friendly',
                      key: ValueKey(3),
                    ),
    );
  }
}

class SingleIsland extends StatelessWidget {
  final String text;
  const SingleIsland(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.pink, fontSize: 55),
    );
  }
}
