import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/ui_helper.dart';
import '../../utils/utils.dart';
import '../custom_widgets.dart';
import '/screens/cart.dart';
import '/screens/Login/login_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.hasBackButton = true,
    this.onBackTap,
    this.isTitleCentered,
    this.isHeroAnimated = true,
    this.actions,
    this.showLogoutButton = false,
    this.showOptions = true,
  }) : super(key: key);

  final String title;
  final bool hasBackButton;
  final VoidCallback? onBackTap;
  final bool? isTitleCentered;
  final List<Widget>? actions;
  final bool isHeroAnimated;
  final bool showLogoutButton;
  final bool showOptions;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: isHeroAnimated ? 'app_bar' : 'no_hero_animation',
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.only(
          top: rh(50),
          left: space2x,
          right: space2x,
          bottom: rh(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                if (showLogoutButton) // Condition to show logout button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginForm()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: showOptions ? Colors.black : Colors.white,
                          ),
                          SizedBox(width: rw(space1x)),
                          Text(
                            'LOGOUT',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: rf(14),
                              color: showOptions ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (hasBackButton)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: onBackTap ?? () => Navigation.pop(context),
                      child: Row(
                        children: [
                          PlatformIcon(
                            color: showOptions ? Colors.black : Colors.white,
                          ),
                          Text(
                            'Back',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: rf(14),
                              color: showOptions ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                Align(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),

                if (showOptions)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                          },
                          child: CIcons.fromMaterial(
                            icon: Icons.shopping_bag_outlined,
                            semanticLabel: 'Bag',
                          ),
                        ),
                        SizedBox(width: rw(space3x)),
                        CIcons.fromMaterial(
                          icon: Icons.favorite_outline,
                          semanticLabel: 'Heart',
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlatformIcon extends StatelessWidget {
  const PlatformIcon({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Buttons.icon(
      context: context,
      icon: CupertinoIcons.back,
      right: space1x,
      iconColor: color,
      semanticLabel: 'Back',
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
