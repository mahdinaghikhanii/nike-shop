import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/utils.dart';
import '../../data/entity/baner_model.dart';
import 'image.dart';

class BannerSlider extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<BannerEntity> banners;
  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2,
        child: Stack(
          children: [
            PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                physics: defaultScrollPhysics,
                itemBuilder: ((context, index) {
                  return _Slide(banner: banners[index]);
                })),
            Positioned(
              right: 0,
              left: 0,
              bottom: 8,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: banners.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                      spacing: 4.0,
                      radius: 4.0,
                      dotWidth: 20.0,
                      dotHeight: 3.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey.shade400,
                      activeDotColor:
                          Theme.of(context).colorScheme.onBackground),
                ),
              ),
            )
          ],
        ));
  }
}

class _Slide extends StatelessWidget {
  final BannerEntity banner;
  const _Slide({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ImageLoadingService(
        imgUrl: banner.image.toString(),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
