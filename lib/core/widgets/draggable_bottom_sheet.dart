import 'package:cabby/core/resources/color_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({super.key, required this.slivers});

  final List<SliverList> slivers;

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  final double _sheetPosition = 0.4;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snapAnimationDuration: const Duration(milliseconds: 300),
      initialChildSize: _sheetPosition,
      snap: true,
      snapSizes: [_sheetPosition, 0.7],
      maxChildSize: 0.7,
      minChildSize: _sheetPosition,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Grabber(
                isOnDesktopAndWeb: _isOnDesktopAndWeb,
              ),
              Flexible(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: widget.slivers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

/// A draggable widget that accepts vertical drag gestures
/// and this is only visible on desktop and web platforms.
class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.isOnDesktopAndWeb,
  });

  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    // if (!isOnDesktopAndWeb) {
    //   return const SizedBox.shrink();
    // }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 50.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: const Color(0xFFDADADD),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
