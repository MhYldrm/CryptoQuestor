import 'package:crypto_questor/product/repository/profile_info_repository.dart';
import 'package:flutter/material.dart';
import '../../product/services/firebase_service/firebase_service.dart';

class ProfileInfoViewModel extends ChangeNotifier {
  ProfileInfoViewModel(this.repository);
  final ProfileInfoRepository repository;

  // FirebaseService handles the data fetching logic for portfolio coins.
  final FirebaseService _service = FirebaseService();

  // Stores the list of user's info fetched from Firebase.
  List? _profileInfoList;

  // Tracks the loading state. [true] if data is being fetched.
  bool _isLoading = false;

  // Provides the list of user's info to external consumers.
  // Returns an empty list if no data is available.
  List get profileInfoList => _profileInfoList ?? [];
  bool get isLoading => _isLoading;

  // Fetches user's info data from Firebase and updates the state.
  Future<void> getUserInfo(String uid) async {
    _isLoading = true;
    notifyListeners();

    // Fetch data from Firebase and assign it to _profileInfoList.
    _profileInfoList = await _service.getInfo(uid);

    _isLoading = false;
    notifyListeners();
  }
}
