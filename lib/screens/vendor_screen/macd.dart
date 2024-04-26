import 'package:bsf/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:bsf/core/animations/animations.dart';
import 'package:bsf/core/utils/ui_helper.dart';
import 'package:bsf/core/utils/utils.dart';
import 'package:bsf/core/widgets/custom_widgets.dart';
import 'package:bsf/data.dart';
import 'package:bsf/screens/home_screen/widgets/clipped_container.dart';
import 'package:bsf/screens/product_screen/product_screen.dart';
import 'package:bsf/screens/vendor_screen/widgets/product_item_card.dart';
import 'package:bsf/screens/vendor_screen/widgets/vendor_info_card.dart';
import 'package:bsf/core/widgets/app_bar/custom_app_bar.dart' as CoreAppBar;


class VendorScreen extends StatefulWidget {
  static const String macd = '/vendor';
  final Vendor vendor;

  const VendorScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  late double _height;

  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);

  _navigate() async {
    await _animateContainerFromBottomToTop();

    //push to products screen
    //wait till product is popped
    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: ProductScreen(),
        type: PageTransitionType.fadeIn,
      ),
    );

    await _animateContainerFromTopToBottom();
  }

  _navigateBack() async {
    await _animateContainerFromBottomToTop();

    Navigation.pop(context);
  }

  _animateContainerFromBottomToTop() async {
    //Animate back to default value
    _height = MediaQuery.of(context).padding.top + rh(50);
    setState(() {});

    //Wait till animation is finished
    await Future.delayed(_duration);
  }

  _animateContainerFromTopToBottom() async {
    //Wait
    await Future.delayed(_psudoDuration);

    //Animate from top to bottom
    _height = MediaQuery.of(context).size.height;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //Default height
    _height = MediaQuery.of(context).padding.top + rh(50);
    setState(() {});

    //Animate Container from Top to bottom
    _animateContainerFromTopToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        height: _height,
        duration: _duration,
        padding: EdgeInsets.only(bottom: rh(20)),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: rh(380),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      height: rf(330),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/mac/mban.png',
                          width: 100 * SizeConfig.heightMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: CoreAppBar.CustomAppBar( // Using the alias for CustomAppBar
                        onBackTap: _navigateBack,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClippedContainer(
                        backgroundColor: Colors.white,
                        child: VendorInfoCard(
                          title: 'MacDonalds',
                          rating: 4.2,
                          sideImagePath: 'assets/images/logo/macd.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: rh(space5x)),
              FadeAnimation(
                intervalStart: 0.4,
                duration: const Duration(milliseconds: 1250),
                child: SlideAnimation(
                  begin: const Offset(0, 100),
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds: 1250),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: productList.length,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: rh(space4x),
                          endIndent: rw(20),
                          indent: rw(20),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: _navigate,
                          child: ProductItem(
                            imagePath: maclist[index]['imagePath'],
                            title: maclist[index]['title'],
                            detail: maclist[index]['detail'],
                            isFavorite: false,
                            onFavoritePressed: () {
                              // Implement your favorite functionality here
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}