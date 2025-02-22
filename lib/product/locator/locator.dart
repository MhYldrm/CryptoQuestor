import 'package:get_it/get_it.dart';
import '../../feature/view_models/gecko_coins_view_model.dart';
import '../../feature/view_models/portfolio_coins_view_model.dart';
import '../../feature/view_models/project_theme_view_model.dart';
import '../../feature/view_models/user_view_model.dart';
import '../repository/coin_gecko_repository_impl.dart';
import '../repository/portfolio_coins_repository_impl.dart';
import '../services/coin_services.dart';
import '../services/firebase_service.dart';


final getIt = GetIt.instance;

void setupLocator() {
  // FirebaseService ve CoinService (Data Source)
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<CoinService>(CoinService());


  // Repository'ler
  getIt.registerSingleton<PortfolioCoinsRepositoryImpl>(
    PortfolioCoinsRepositoryImpl(getIt<FirebaseService>()),
  );
  getIt.registerSingleton<CoinGeckoRepositoryImpl>(
    CoinGeckoRepositoryImpl(getIt<CoinService>()),
  );

  // ViewModel'ler
  getIt.registerFactory(() => PortfolioCoinsViewModel(getIt<PortfolioCoinsRepositoryImpl>()));
  getIt.registerFactory(() => GeckoCoinsViewModel(getIt<CoinGeckoRepositoryImpl>()));
  getIt.registerFactory(() => UserViewModel());
  getIt.registerFactory(() => ProjectThemeViewModel());
}
