/// A mixin to manage the EarnPage Page State.
/// [_service] An object to use functions in [CoinService] class.
/// [_earnListNotifier] This is used to notify listeners whenever the earn projects data is updated.
/// [_isLoadingNotifier] A [ValueNotifier] holding a boolean value to indicate whether the data is still loading or has finished loading.
///
part of '../earn_page.dart';

mixin EarnPageMixin on State<EarnPage> {
  final CoinService _service = CoinService();
  final ValueNotifier<List<EarnModel>> _earnListNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(true);
  final _firebaseServices = FirebaseService().firebaseAuth;

  String _getHeaderNameTitle () {
    String name = _firebaseServices.currentUser?.displayName ??
         _firebaseServices.currentUser?.email ??
         context.mLocalizations.cryptoLover;
    return name;
  }

  Future<void> _fetchEarnProjects() async {
    final value = await _service.getEarnProjectsFromGithub();
    if (value != null) {
      _earnListNotifier.value = value;
      _isLoadingNotifier.value = false;
    } else {
      _isLoadingNotifier.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEarnProjects();
  }
}
