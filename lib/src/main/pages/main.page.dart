import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';
import 'package:snp_garbage_collection/src/router/widget/app_router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return AutoTabsScaffold(
      animationDuration: const Duration(seconds: 0),
      routes: const [
        HomeTabRouter(),
        DraftTabRouter(),
        ProfileTabRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return WillPopScope(
          onWillPop: () async {
            // When User press back button, we will switch to HomeTab, if we are not on HomeTab
            if (tabsRouter.activeIndex != 0) {
              tabsRouter.setActiveIndex(0);
            }
            // this will prevent the back button from closing the app
            return false;
          },
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            currentIndex: tabsRouter.activeIndex,
            onTap: (value) {
              // when user tap on the active tab, it will change the active tab is on the top of the stack
              // if not, it will just pop the stack
              if (value != tabsRouter.activeIndex) {
                tabsRouter.setActiveIndex(value);
              } else {
                tabsRouter.popTop();
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:
                    PendingBadgeCount(child: FaIcon(FontAwesomeIcons.listAlt)),
                label: 'Draft',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

/// This is a custom badge widget, it will show the number of pending draft
class PendingBadgeCount extends StatelessWidget {
  const PendingBadgeCount({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final count = context.watch<DraftCubit>().state.totalCount;

    if (count == 0) {
      return child;
    }

    final style = Theme.of(context).textTheme.caption?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );

    return Badge(
      badgeContent: Text(
        '$count',
        style: style,
      ),
      child: child,
    );
  }
}
