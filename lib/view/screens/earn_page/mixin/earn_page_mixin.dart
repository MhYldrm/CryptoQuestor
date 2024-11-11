import 'package:crypto_questor/view/screens/earn_page/earn_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/earn_model.dart';
import '../../../../core/services/coin_services.dart';

/// A mixin to manage the EarnPage Page State.
/// [_service] An object to use functions in [CoinService] class.
/// [earnListNotifier] This is used to notify listeners whenever the earn projects data is updated.
/// [isLoadingNotifier] A [ValueNotifier] holding a boolean value to indicate whether the data is still loading or has finished loading.
///
mixin EarnPageMixin on State<EarnPage> {
  final CoinService _service = CoinService();
  ValueNotifier<List<EarnModel>> earnListNotifier = ValueNotifier([]);
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(true);

  Future<void> _fetchEarnProjects() async {
    final value = await _service.getEarnProjectsFromGithub();
    if (value != null) {
      earnListNotifier.value = value;
      isLoadingNotifier.value = false;
    } else {
      isLoadingNotifier.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEarnProjects();
  }
}
