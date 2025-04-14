import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:raff/business_managers/api_model/intro/intro_response.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroItem extends StatefulWidget {
  final IntroModel model;
  final PageController controller;
  final int length;

  const IntroItem(
      {super.key,
      required this.model,
      required this.controller,
      required this.length});

  @override
  State<IntroItem> createState() => _IntroItemState();
}

class _IntroItemState extends State<IntroItem>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400), // Animation duration
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Start from bottom
      end: Offset(0, 0), // End at original position
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    ));

    _animationController!.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1,
          child: Lottie.network(
            widget.model.imageUrl ?? '',
            width: 100.w,
            height: 52.h,
          ),
        ),
        SlideTransition(
          position: _animation!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.model.title!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.model.description!,
                style:
                    TextStyle(color: AppColors().greyTextColor, fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                controller: widget.controller,
                count: widget.length,
                effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 12,
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors().inActiveDotColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
