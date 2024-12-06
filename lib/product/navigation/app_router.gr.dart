// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddPortfolioPage]
class AddPortfolioRoute extends PageRouteInfo<AddPortfolioRouteArgs> {
  AddPortfolioRoute({
    Key? key,
    dynamic selectCoin,
    List<PageRouteInfo>? children,
  }) : super(
          AddPortfolioRoute.name,
          args: AddPortfolioRouteArgs(
            key: key,
            selectCoin: selectCoin,
          ),
          initialChildren: children,
        );

  static const String name = 'AddPortfolioRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddPortfolioRouteArgs>(
          orElse: () => const AddPortfolioRouteArgs());
      return AddPortfolioPage(
        key: args.key,
        selectCoin: args.selectCoin,
      );
    },
  );
}

class AddPortfolioRouteArgs {
  const AddPortfolioRouteArgs({
    this.key,
    this.selectCoin,
  });

  final Key? key;

  final dynamic selectCoin;

  @override
  String toString() {
    return 'AddPortfolioRouteArgs{key: $key, selectCoin: $selectCoin}';
  }
}

/// generated route for
/// [CoinDetailPage]
class CoinDetailRoute extends PageRouteInfo<CoinDetailRouteArgs> {
  CoinDetailRoute({
    Key? key,
    dynamic selectCoin,
    List<PageRouteInfo>? children,
  }) : super(
          CoinDetailRoute.name,
          args: CoinDetailRouteArgs(
            key: key,
            selectCoin: selectCoin,
          ),
          initialChildren: children,
        );

  static const String name = 'CoinDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CoinDetailRouteArgs>(
          orElse: () => const CoinDetailRouteArgs());
      return CoinDetailPage(
        key: args.key,
        selectCoin: args.selectCoin,
      );
    },
  );
}

class CoinDetailRouteArgs {
  const CoinDetailRouteArgs({
    this.key,
    this.selectCoin,
  });

  final Key? key;

  final dynamic selectCoin;

  @override
  String toString() {
    return 'CoinDetailRouteArgs{key: $key, selectCoin: $selectCoin}';
  }
}

/// generated route for
/// [EarnDetailsPage]
class EarnDetailsRoute extends PageRouteInfo<EarnDetailsRouteArgs> {
  EarnDetailsRoute({
    Key? key,
    required EarnModel earnModel,
    List<PageRouteInfo>? children,
  }) : super(
          EarnDetailsRoute.name,
          args: EarnDetailsRouteArgs(
            key: key,
            earnModel: earnModel,
          ),
          initialChildren: children,
        );

  static const String name = 'EarnDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EarnDetailsRouteArgs>();
      return EarnDetailsPage(
        key: args.key,
        earnModel: args.earnModel,
      );
    },
  );
}

class EarnDetailsRouteArgs {
  const EarnDetailsRouteArgs({
    this.key,
    required this.earnModel,
  });

  final Key? key;

  final EarnModel earnModel;

  @override
  String toString() {
    return 'EarnDetailsRouteArgs{key: $key, earnModel: $earnModel}';
  }
}

/// generated route for
/// [IntroPage]
class IntroRoute extends PageRouteInfo<void> {
  const IntroRoute({List<PageRouteInfo>? children})
      : super(
          IntroRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntroPage();
    },
  );
}

/// generated route for
/// [PortfolioPage]
class PortfolioRoute extends PageRouteInfo<void> {
  const PortfolioRoute({List<PageRouteInfo>? children})
      : super(
          PortfolioRoute.name,
          initialChildren: children,
        );

  static const String name = 'PortfolioRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PortfolioPage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}
