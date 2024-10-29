import 'package:dio/dio.dart';

abstract class INetworkManager <T> {
  INetworkManager <T> addBaseUrl (String baseUrl);
  INetworkManager <T> addStatusModels (StatusModels? statusModels);
  INetworkManager <T> addBaseHeaders (MapEntry <String, String> value);
  INetworkManager <T> addTimeOut (Duration value);
  T build();
}




class StatusModels {
  int minValue;
  int maxValue;

  StatusModels({required this.minValue, required this.maxValue}):assert(maxValue > minValue);
}



class NetworkDioManager implements INetworkManager <Dio>{
  Dio? _dio;
  String? _baseUrl;
  StatusModels? _statusModels;
  MapEntry <String, String>? _baseHeader;
  Duration? _timeOut;

  @override
  INetworkManager <Dio> addBaseUrl (String baseUrl){
    _baseUrl = baseUrl;
    return this;
  }

  @override
  INetworkManager <Dio> addStatusModels (StatusModels? statusModels){
    _statusModels = statusModels;
    return this;
  }

  @override
  INetworkManager <Dio> addTimeOut(Duration value) {
    _timeOut = value;
    return this;
  }

  @override
  INetworkManager <Dio> addBaseHeaders(MapEntry<String, String> value) {
    _baseHeader = value;
    return this;
  }

  @override
  Dio build() {
    _dio = Dio(
        BaseOptions(
            baseUrl: _baseUrl ?? '',
            headers: Map.fromEntries([_baseHeader ?? const MapEntry('token', 'value')]),
            connectTimeout: _timeOut,
            validateStatus: (status){
              if(status != null && _statusModels != null){
                if(status >= _statusModels!.minValue && status <= _statusModels!.maxValue){
                  return true;
                }
              }
              return false;
            }
        )
    );

    return _dio!;
  }

}