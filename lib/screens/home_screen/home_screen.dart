import 'dart:async';
import 'package:bsf/screens/home_screen/widgets/vendor_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bsf/core/animations/animations.dart';
import 'package:bsf/core/animations/fade_animation.dart';
import 'package:bsf/core/animations/slide_animation.dart';
import 'package:bsf/core/utils/navigation.dart';
import 'package:bsf/core/utils/ui_helper.dart';
import 'package:bsf/core/widgets/custom_widgets.dart';
import 'package:bsf/data.dart';
import '../vendor_screen/vendor_screen.dart';
import 'package:bsf/screens/home_screen/widgets/category_list_view.dart';
import 'package:bsf/screens/home_screen/widgets/clipped_container.dart';
import 'package:bsf/screens/vendor_screen/vendor_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  late double _height;
  final _duration = const Duration(milliseconds: 750);
  final _pseudoDuration = const Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SlideAnimation(
        begin: const Offset(0, 400),
        duration: _duration,
        child: AnimatedContainer(
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
                const CustomAppBar(
                  hasBackButton: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: space2x),
                  child: RichText(
                    text: TextSpan(
                      text: 'Hi, ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: rf(24),
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${FirebaseAuth.instance.currentUser?.displayName}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: rf(24)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: space2x),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to abcd.dart when "MY HOME" is tapped
                      Navigation.push(context, name: 'abcd.dart');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'DELIVER TO ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: rf(12),
                          height: 1.5,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'MY HOME',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              // Add any other styles you need
                            ),
                          ),
                          TextSpan(
                            text: '\u2304', //
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: rh(space4x)),
                ClippedContainer(
                  // backgroundColor:
                  // Theme.of(context).colorScheme.secondary,
                  child: const CategoryListView(),
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
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: vendorList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return Divider(
                            height: rh(space2x),
                            endIndent: rw(20),
                            indent: rw(20),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: _navigate,
                            child: VendorCard(
                              imagePath: vendorList[index]['imagePath'],
                              name: vendorList[index]['name'],
                              rating: vendorList[index]['rating']
                                  .toString(),
                            ),
                          );
                        },
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigate() async {
    // Animate screen container from bottom to top
    // await _animateContainerFromBottomToTop();

    // Navigate to VendorScreen
    await Navigation.push(
      context,
      name: 'abcd.dart', // Specify the route here
      customPageTransition: PageTransition(
        child: const VendorScreen(),
        type: PageTransitionType.fadeIn,
      ),
    );

    // Animate screen container from top to bottom
    // await _animateContainerFromTopToBottom();
  }

  Future<void> _animateContainerFromBottomToTop() async {
    // Animate back to default value
    _height = MediaQuery.of(context).padding.top + rh(50);
    setState(() {});

    // Wait till animation is finished
    await Future.delayed(_duration);
  }

  Future<void> _animateContainerFromTopToBottom() async {
    // Wait
    await Future.delayed(_pseudoDuration);

    // Animate from top to bottom
    _height = MediaQuery.of(context).size.height;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Default height
    _height = 0;
    setState(() {});

    // Animate Container from Top to bottom
    Timer(const Duration(milliseconds: 50), () {
      _animateContainerFromTopToBottom();
    });
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Theme.of(context).primaryColor,
//     body: SlideAnimation(
//       begin: const Offset(0, 400),
//       duration: _duration,
//       child: AnimatedContainer(
//         height: _height,
//         duration: _duration,
//         padding: EdgeInsets.only(bottom: rh(20)),
//         curve: Curves.fastOutSlowIn,
//         decoration: BoxDecoration(
//           color: Theme.of(context).scaffoldBackgroundColor,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const CustomAppBar(
//                 hasBackButton: false,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: space2x),
//                 child: RichText(
//                   text: TextSpan(
//                     text: 'Hi, ',
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: rf(24),
//                       fontWeight: FontWeight.normal,
//                     ),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: 'Sana',
//                         style: Theme.of(context).textTheme.headline6!.copyWith(
//                           fontSize: rf(24),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: space2x),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Navigate to abcd.dart when "MY HOME" is tapped
//                     Navigation.push(context, name: 'abcd.dart');
//                   },
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'DELIVER TO ',
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         fontSize: rf(12),
//                         height: 1.5,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'MY HOME',
//                           style: TextStyle(
//                             decoration: TextDecoration.underline,
//                             // Add any other styles you need
//                           ),
//                         ),
//                         TextSpan(
//                           text: '\u2304', //
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: rh(space4x)),
//               ClippedContainer(
//                 backgroundColor: Theme.of(context).colorScheme.secondary,
//                 child: const CategoryListView(),
//               ),
//               SizedBox(height: rh(space5x)),
//               FadeAnimation(
//                 intervalStart: 0.4,
//                 duration: const Duration(milliseconds: 1250),
//                 child: SlideAnimation(
//                   begin: const Offset(0, 100),
//                   intervalStart: 0.4,
//                   duration: const Duration(milliseconds: 1250),
//                   child: ListView.separated(
//                     itemCount: vendorList.length,
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     separatorBuilder: (BuildContext context, int index) {
//                       return Divider(
//                         height: rh(space4x),
//                         endIndent: rw(20),
//                         indent: rw(20),
//                       );
//                     },
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context,'/vendor_screen');
//                         },
//                         child: VendorCard(
//                           imagePath: vendorList[index]['imagePath'],
//                           name: vendorList[index]['name'],
//                           rating: vendorList[index]['rating'].toString(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

