import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../feature/screens/add_portfolio_page/add_portfolio_page.dart';
import '../../feature/screens/coin_details_page/coin_details_page.dart';
import '../../feature/screens/earn_details_page/earn_details_page.dart';
import '../../feature/screens/intro_page/intro_page.dart';
import '../../feature/screens/portfolio_page/portfolio_page.dart';
import '../../feature/screens/sign_in_page/sign_in_page.dart';
import '../../feature/screens/sign_up_page/sign_up_page.dart';
import '../../feature/screens/splash_page/splash_page.dart';
import '../models/earn_model.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: IntroRoute.page,
        ),
        AutoRoute(
          page: AddPortfolioRoute.page,
        ),
        AutoRoute(
          page: EarnDetailsRoute.page,
        ),
        AutoRoute(
          page: CoinDetailRoute.page,
        ),
        AutoRoute(
          page: PortfolioRoute.page,
        ),
      ];
}
