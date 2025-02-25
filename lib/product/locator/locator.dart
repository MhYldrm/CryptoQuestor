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
  // FirebaseService ve CoinService (Data Source)
  getIt
    ..registerSingleton<FirebaseService>(FirebaseService())
    ..registerSingleton<CoinService>(CoinService())

    // Repository'ler
    ..registerSingleton<PortfolioCoinsRepositoryImpl>(
      PortfolioCoinsRepositoryImpl(getIt<FirebaseService>()),
    )
    ..registerSingleton<CoinGeckoRepositoryImpl>(
      CoinGeckoRepositoryImpl(getIt<CoinService>()),
    )

    // ViewModel'ler
    ..registerFactory(
      () => PortfolioCoinsViewModel(getIt<PortfolioCoinsRepositoryImpl>()),
    )
    ..registerFactory(
      () => GeckoCoinsViewModel(getIt<CoinGeckoRepositoryImpl>()),
    )
    ..registerFactory(() => UserViewModel())
    ..registerFactory(() => ProjectThemeViewModel());
}
