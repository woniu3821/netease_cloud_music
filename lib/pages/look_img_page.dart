import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class LookImgPage extends StatefulWidget {
  final List<String> imgs;
  final int curIndex;

  LookImgPage(this.imgs, this.curIndex);

  @override
  _LookImgPageState createState() => _LookImgPageState();
}

class _LookImgPageState extends State<LookImgPage> {
  int curIndex;
  GlobalKey<ExtendedImageSlidePageState> slidePageKey =
      GlobalKey<ExtendedImageSlidePageState>();

  @override
  void initState() {
    super.initState();
    curIndex = widget.curIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: ExtendedImageSlidePage(
        key: slidePageKey,
        slideAxis: SlideAxis.both,
        slideType: SlideType.onlyImage,
        child: ExtendedImageGesturePageView.builder(
          itemBuilder: (context, index) {
            var item = widget.imgs[index];
            Widget image = ExtendedImage.network(
              item,
              enableSlideOutPage: true,
              mode: ExtendedImageMode.gesture,
              heroBuilderForSlidingPage: (r) {
                return Hero(
                  tag: item + index.toString(),
                  child: r,
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    final Hero hero = flightDirection == HeroFlightDirection.pop
                        ? fromHeroContext.widget
                        : toHeroContext.widget;
                    return hero.child;
                  },
                );
              },
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  inPageView: true,
                  initialScale: 1.0,
                  cacheGesture: false,
                );
              },
            );

            return GestureDetector(
              child: image,
              onTap: () {
                Navigator.pop(context);
              },
            );
          },
          itemCount: widget.imgs.length,
          controller: PageController(
            initialPage: curIndex,
          ),
          scrollDirection: Axis.horizontal,
        ),
      ),
      data: ThemeData(dialogBackgroundColor: Colors.black),
    );
  }
}
