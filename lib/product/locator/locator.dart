import 'package:crypto_questor/feature/view_models/profile_info_view_model.dart';
import 'package:crypto_questor/product/repository/profile_info_repository_impl.dart';
import 'package:get_it/get_it.dart';
import '../../feature/view_models/gecko_coins_view_model.dart';
import '../../feature/view_models/portfolio_coins_view_model.dart';
import '../../feature/view_models/project_theme_view_model.dart';
import '../../feature/view_models/user_view_model.dart';
import '../repository/coin_gecko_repository_impl.dart';
import '../repository/portfolio_coins_repository_impl.dart';
import '../services/coin_service/coin_service.dart';
import '../services/firebase_service/firebase_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // FirebaseService and CoinService (Data Source)
  getIt
    ..registerSingleton<FirebaseService>(FirebaseService())
    ..registerSingleton<CoinService>(CoinService())

    // Repositories
    ..registerSingleton<PortfolioCoinsRepositoryImpl>(
      PortfolioCoinsRepositoryImpl(getIt<FirebaseService>()),
    )
    ..registerSingleton<CoinGeckoRepositoryImpl>(
      CoinGeckoRepositoryImpl(getIt<CoinService>()),
    )
    ..registerSingleton<ProfileInfoRepositoryImpl>(
      ProfileInfoRepositoryImpl(getIt<FirebaseService>()),
    )

    // ViewModels
    ..registerFactory(
      () => PortfolioCoinsViewModel(getIt<PortfolioCoinsRepositoryImpl>()),
    )
    ..registerFactory(
      () => GeckoCoinsViewModel(getIt<CoinGeckoRepositoryImpl>()),
    )
    ..registerFactory(
          () => ProfileInfoViewModel(getIt<ProfileInfoRepositoryImpl>()),
    )
    ..registerFactory(() => UserViewModel())
    ..registerFactory(() => ProjectThemeViewModel());
}
