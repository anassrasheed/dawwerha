import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingActionBubble extends StatefulWidget {
  const FloatingActionBubble({
    Key? key,
    required this.items,
    required this.onPress,
    required this.iconColor,
    required this.backGroundColor,
    required this.animation,
    this.herotag,
    this.iconData,
    this.animatedIconData,
  })  : assert((iconData == null && animatedIconData != null) ||
            (iconData != null && animatedIconData == null)),
        super(key: key);

  final List<Bubble> items;
  final void Function() onPress;
  final AnimatedIconData? animatedIconData;
  final Object? herotag;
  final IconData? iconData;
  final Color iconColor;
  final Color backGroundColor;
  final Animation<double> animation;

  @override
  _FloatingActionBubbleState createState() => _FloatingActionBubbleState();
}

class _FloatingActionBubbleState extends State<FloatingActionBubble>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _rotationBubblesController;
  late Animation<double> _rotationAnimation;
  Animation<Offset>? _rotationBubblesAnimation;
  Animation<Offset>? _rotationBubbles2Animation;
  Animation<Offset>? _rotationBubbles3Animation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _rotationBubblesController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _rotationAnimation = Tween<double>(begin: 0.0, end: 60.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
    _rotationBubblesAnimation = Tween<Offset>(
      begin: Offset(1, 2), // Start from bottom
      end: Offset(0, 0), // End at original position
    ).animate(CurvedAnimation(
      parent: _rotationBubblesController,
      curve: Curves.easeOut,
    ));
    _rotationBubbles2Animation = Tween<Offset>(
      begin: Offset(0, 2), // Start from bottom
      end: Offset(0, 0), // End at original position
    ).animate(CurvedAnimation(
      parent: _rotationBubblesController,
      curve: Curves.easeOut,
    ));
    _rotationBubbles3Animation = Tween<Offset>(
      begin: Offset(-1, 2), // Start from bottom
      end: Offset(0, 0), // End at original position
    ).animate(CurvedAnimation(
      parent: _rotationBubblesController,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rotationController.forward();
      _rotationBubblesController.forward();
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Widget buildItem(
      BuildContext context, int index, Animation<Offset> position) {
    return GestureDetector(
      onTap: widget.items[index].onPress,
      child: SlideTransition(
          position: position,
          child: Container(
            child: Transform.scale(
              child: widget.items[index]._icon,
              scale: 3.3,
            ),
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 50,
            height: 50,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IgnorePointer(
              ignoring: widget.animation.value == 0,
              child: Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildItem(context, 0, _rotationBubblesAnimation!),
                    buildItem(context, 1, _rotationBubbles2Animation!),
                    buildItem(context, 2, _rotationBubbles3Animation!),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.onPress.call();
              },
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Transform.rotate(
                      angle: _rotationAnimation.value *
                          (3.141592653589793 / 80), // Convert to radians
                      child: Transform.scale(
                        child: SvgPicture.asset('assets/plus_icon.svg'),
                        scale: 1,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Bubble {
  const Bubble({
    required Widget icon,
    required Color iconColor,
    required String title,
    required TextStyle titleStyle,
    required Color bubbleColor,
    required this.onPress,
  })  : _icon = icon,
        _title = title,
        _titleStyle = titleStyle,
        _bubbleColor = bubbleColor;

  final Widget _icon;
  final String _title;
  final TextStyle _titleStyle;
  final Color _bubbleColor;
  final void Function() onPress;
}

class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item, {Key? key}) : super(key: key);

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.only(top: 11, bottom: 13, left: 32, right: 32),
      color: item._bubbleColor,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 2,
      highlightElevation: 2,
      disabledColor: item._bubbleColor,
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          item._icon,
          const SizedBox(
            width: 10.0,
          ),
          Text(
            item._title,
            style: item._titleStyle,
          ),
        ],
      ),
    );
  }
}
