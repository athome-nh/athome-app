// Import necessary packages and libraries
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A carousel slider widget that displays a series of images with optional placeholders.
/// It also uses a shimmer effect when loading images, and handles user interaction for navigation.

class Carousel extends StatelessWidget {
  final productProvider pro;

  /// Constructor requires a product provider for data and operations.
  Carousel(this.pro, {Key? key}) : super(key: key);

  /// Temporary list of strings used when no image data is available from the provider.
  final List<String> temp = [
    "sddsdsdsd",
    "sddsdsdsd",
    "sddsdsdsd",
    "sddsdsdsd",
    "sddsdsdsd",
  ];

  @override
  Widget build(BuildContext context) {
    /// A list of image widgets built dynamically depending on whether data is available.
    List<Widget> imageSliders = pro.show
        ? pro.slides
            .map((item) => Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: GestureDetector(
                      /// On tap, navigates to a new page with the selected item's details.
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
                          /// Retrieves the image from the network.
                          imageUrl: dotenv.env['imageUrlServer']! + item.img!,
                          
                          /// Placeholder image shown while loading.
                          placeholder: (context, url) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                              
                          /// Error image displayed if the network image fails to load.
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          filterQuality: FilterQuality.low,
                          width: getWidth(context, 100) - 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList()
        : temp
            .map((item) => Skeletonizer(
                  enabled: true,
                  effect: ShimmerEffect.raw(colors: [
                    mainColorGrey.withOpacity(0.1),
                    mainColorWhite,
                  ]),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            /// No action when tapped as the image is just a placeholder.
                            onTap: () {},
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  "assets/shimmer/flag.png",
                                  width: getWidth(context, 100) - 80,
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
            .toList();

    return RepaintBoundary(
      /// CarouselSlider widget that automatically rotates through images.
      child: CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 0.9,
            aspectRatio: 2.5,
            enableInfiniteScroll: true,
            initialPage: 1,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5)),
        items: imageSliders,
      ),
    );
  }

  /// Builds the indicator for the active image in the carousel.
  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0),
                  )
                : BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
