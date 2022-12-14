import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration duration;

  const ScrollToHideWidget(
      {Key? key,
      required this.child,
      required this.scrollController,
      this.duration = const Duration(milliseconds: 200)})
      : super(key: key);

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(listen);
  }

  @override
  void dispose() {
    widget.scrollController.addListener(listen);

    super.dispose();
  }

  /*void listen() {
    final direction = widget.scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }*/
  void listen() {
    if (widget.scrollController.positions.any(
        (element) => element.userScrollDirection == ScrollDirection.forward)) {
      show();
    } else if (widget.scrollController.positions.any(
        (element) => element.userScrollDirection == ScrollDirection.reverse)) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState((() => isVisible = true));
  }

  void hide() {
    if (isVisible) setState((() => isVisible = false));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight : 0,
      child: Wrap(children: [widget.child]),
    );
  }
}
