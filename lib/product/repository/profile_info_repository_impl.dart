import 'package:crypto_questor/product/repository/profile_info_repository.dart';
import 'package:crypto_questor/product/services/firebase_service/firebase_service.dart';

class ProfileInfoRepositoryImpl implements ProfileInfoRepository{
  ProfileInfoRepositoryImpl(this._service);
  final FirebaseService _service;

  @override
  Future<List> getProfileInfo(String uid) async {
   return await _service.getInfo(uid);
  }
}