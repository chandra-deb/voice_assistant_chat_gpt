import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
              'Copied!',
              key: ValueKey(0),
            )
          : island == Island.deleting
              ? const SingleIsland(
                  'Deleted!',
                  key: ValueKey(1),
                )
              : island == Island.sharing
                  ? const SingleIsland(
                      'Shared!',
                      key: ValueKey(2),
                    )
                  : island == Island.loading
                      ? const ResponseLoadingIsland()
                      : island == Island.cancelling
                          ? const SingleIsland(
                              'Cancelled.',
                              key: ValueKey(3),
                            )
                          : island == Island.name
                              ? const SingleIsland(
                                  'Friendly!',
                                  key: ValueKey(4),
                                )
                              : null,
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

class ResponseLoadingIsland extends StatelessWidget {
  const ResponseLoadingIsland({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: 60,
      child: LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [Colors.red, Colors.purple, Colors.blueAccent],
        strokeWidth: 2,
      ),
    );
  }
}
