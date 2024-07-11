import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/controller/productprovider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class Carousel extends StatelessWidget {
  productProvider pro;
  Carousel(this.pro, {Key? key}) : super(key: key);
  List<String> a = [
    "sddsdsdsd",
    "sddsdsdsd",
    "sddsdsdsd",
    "sddsdsdsd",
    "sddsdsdsd",
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = !pro.show
        ? a
            .map((item) => Skeletonizer(
                  enabled: true,
                  effect: ShimmerEffect.raw(colors: [
                    mainColorGrey.withOpacity(0.1),
                    mainColorWhite,
                    // mainColorRed.withOpacity(0.1),
                  ]),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  "assets/shimmer/flag.png",
                                  width: getWidth(context, 100) - 48,
                                  fit: BoxFit.fill,
                                )),
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
                  ),
                ))
            .toList()
        : pro.slides
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
                              imageUrl:
                                  dotenv.env['imageUrlServer']! + item.img!,
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
}
