import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;
  bool loadingVisibility=false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();

    _animation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 1.3),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.3, end: 1.0),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    // _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.bounceInOut,
    //   ),
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black54
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, child) {
            return ScaleTransition(
              scale: _animation,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                  ),
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 150.0 * _controller.value,
                height: 150.0 * _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }

}
