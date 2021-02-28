import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/features/onboard/widegts/create_or_restore.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/onboard/widegts/flare_controller.dart';
import 'package:fusecash/features/onboard/widegts/on_boarding_pages.dart';
import 'package:fusecash/redux/viewsmodels/splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  HouseController _slideController;
  ValueNotifier<double> notifier;

  void _onScroll() {
    _slideController.rooms = _pageController.page;
  }

  @override
  void initState() {
    super.initState();
    _slideController = HouseController(onUpdated: _update);

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);
  }

  _update() => setState(() {});

  void gotoPage(page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    // List pages = getPages(context);
    List<Widget> welcomeScreens = [
      WelcomeFrame(
        title: I18n.of(context).simple,
        subTitle: I18n.of(context).intro_text_one,
      ),
      WelcomeFrame(
        title: I18n.of(context).useful,
        subTitle: I18n.of(context).intro_text_two,
      ),
      WelcomeFrame(
        title: I18n.of(context).smart,
        subTitle: I18n.of(context).intro_text_three,
      ),
      CreateWallet()
    ];
    return StoreConnector<AppState, SplashViewModel>(
      onInitialBuild: (viewModel) {
        Segment.screen(screenName: '/splash-screen');
      },
      distinct: true,
      converter: SplashViewModel.fromStore,
      builder: (_, viewModel) {
        return Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 18,
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 100,
                            left: 20,
                            right: 20,
                          ),
                          child: FlareActor(
                            "assets/images/animation.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            controller: _slideController,
                          ),
                        ),
                        PageView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _pageController,
                          itemCount: welcomeScreens.length,
                          itemBuilder: (_, index) => welcomeScreens[index % 4],
                        ),
                        Positioned(
                          bottom: 15.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 40.0, bottom: 20.0),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              onDotClicked: gotoPage,
                              count: welcomeScreens.length,
                              effect: JumpingDotEffect(
                                dotWidth: 10.0,
                                dotHeight: 10.0,
                                dotColor:
                                    Theme.of(context).colorScheme.onSurface,
                                activeDotColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
