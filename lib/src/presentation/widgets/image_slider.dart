import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../providers/carousel_provider.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({super.key});

  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Consumer<CarouselProvider>(
          builder: (context, carouselProvider, child) => CarouselSlider.builder(
            carouselController: controller,
            itemCount: carouselProvider.imageData.length,
            itemBuilder: (context, index, realIndex) {
              final imageData = carouselProvider.imageData[index];
              return buildImage(imageData.imagePath);
            },
            options: CarouselOptions(
              aspectRatio: 16 / 8,
              autoPlay: true,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(seconds: 2),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  context.read<CarouselProvider>().updateActiveIndex(index),
            ),
          ),
        ),
        Positioned(
          bottom: 12.0.h,
          child: buildIndicator(context),
        )
      ],
    );
  }

  Widget buildImage(String imagePath) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0.r),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      );

  Widget buildIndicator(BuildContext context) {
    return Consumer<CarouselProvider>(
      builder: (context, carouselProvider, child) {
        return AnimatedSmoothIndicator(
          onDotClicked: (index) {
            controller.animateToPage(index); // Navigate to the selected page
            carouselProvider
                .updateActiveIndex(index); // Update the active index
          },
          effect: ExpandingDotsEffect(
            dotHeight: 8.0.h,
            dotWidth: 8.0.w,
            activeDotColor: Colors.white,
          ),
          activeIndex: carouselProvider.activeIndex,
          count: carouselProvider.imageData.length,
        );
      },
    );
  }
}
