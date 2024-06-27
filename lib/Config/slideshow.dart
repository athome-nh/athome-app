import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/model/slidemodel/slidemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Carousel extends StatelessWidget {
  productProvider pro;
  Carousel(this.pro, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = pro.slides
        .map((item) => Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        pro.settype("brand");
                        pro.setidbrand(item.brandId!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllItem()),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: dotenv.env['imageUrlServer']! + item.img!,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          filterQuality: FilterQuality.low,
                          width: getWidth(context, 100) - 48,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return RepaintBoundary(
      child: CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 0.9,
            aspectRatio: 3,
            enableInfiniteScroll: true,
            initialPage: 1,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5)),
        items: imageSliders,
      ),
    );
  }

  // Padding(
  //   padding: EdgeInsets.symmetric(
  //       horizontal: getWidth(context, 4)),
  //   child: Visibility(
  //     visible: productrovider.show,
  //     replacement: Skeletonizer(
  //       effect: ShimmerEffect.raw(colors: [
  //         mainColorGrey.withOpacity(0.1),
  //         mainColorWhite,
  //         //  mainColorRed.withOpacity(0.1),
  //       ]),
  //       enabled: true,
  //       child: SizedBox(
  //         width: getWidth(context, 100),
  //         height: getHeight(context, 25),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(15.0),
  //           child: CarouselSlider(
  //             items: [
  //               ClipRRect(
  //                 child: Image.asset(
  //                   "assets/images/Logo-Type-2.png",
  //                   width: getWidth(context, 100),
  //                   height: getHeight(context, 20),
  //                   fit: BoxFit.fill,
  //                 ),
  //               ),
  //             ],
  //             options: CarouselOptions(
  //               autoPlay: true,
  //               aspectRatio: 16 / 9,
  //               viewportFraction: 1.0,
  //               enlargeCenterPage: true,
  //               autoPlayInterval: const Duration(seconds: 5),
  //               autoPlayAnimationDuration:
  //                   const Duration(milliseconds: 3000),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     child: SizedBox(
  //       width: getWidth(context, 100),
  //       height: getHeight(context, 25),
  //       child: Stack(
  //         children: [
  //           CarouselSlider.builder(
  //             itemCount: productrovider.slides.length,
  //             options: CarouselOptions(
  //               autoPlay: true,
  //               aspectRatio: 16 / 9,
  //               viewportFraction: 1.0,
  //               enlargeCenterPage: true,
  //               autoPlayInterval: const Duration(seconds: 5),
  //               autoPlayAnimationDuration:
  //                   const Duration(milliseconds: 3000),
  //               enableInfiniteScroll:
  //                   true, // if you don't want infinite loop
  //               onPageChanged: (index, reason) {
  //                 // Do something when page changes
  //               },
  //             ),
  //             itemBuilder:
  //                 (BuildContext context, int index, _) {
  //               var item = productrovider.slides[index];
  //               return GestureDetector(
  //                 onTap: () {
  //                   productrovider.settype("brand");
  //                   productrovider.setidbrand(item.brandId!);
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) =>
  //                             const AllItem()),
  //                   );
  //                 },
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(15.0),
  //                   child: CachedNetworkImage(
  //                     imageUrl:
  //                         dotenv.env['imageUrlServer']! +
  //                             item.img!,
  //                     placeholder: (context, url) =>
  //                         Image.asset(
  //                             "assets/images/Logo-Type-2.png"),
  //                     errorWidget: (context, url, error) =>
  //                         Image.asset(
  //                             "assets/images/Logo-Type-2.png"),
  //                     filterQuality: FilterQuality.low,
  //                     width: getWidth(context, 100),
  //                     height: getHeight(context, 20),
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // ),
}
