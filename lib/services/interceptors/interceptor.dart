import 'package:dio/dio.dart';
import 'package:sample_latest/extensions/dio_request_extension.dart';
import 'package:sample_latest/services/db/db_configuration.dart';
import 'package:sample_latest/services/db/offline_handler.dart';
import 'package:sample_latest/services/utils/db_constants.dart';
import 'package:sample_latest/utils/connectivity_handler.dart';
import 'package:sample_latest/utils/device_configurations.dart';

class Interceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    if (!ConnectivityHandler().isConnected && options.isOfflineApi && DeviceConfiguration.isOfflineSupportedDevice && DbConfigurationsByDev().storeData && !options.isFromQueueItem) {
      handler.resolve(await OfflineHandler().handleRequest(options));
    }else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {

    if(DbConfigurationsByDev.storeInBothOfflineAndOnline && response.requestOptions.isOfflineApi && !response.requestOptions.isFromQueueItem){
      response.requestOptions.notRequiredToStoreInQueue = true;
      await OfflineHandler().handleRequest(response.requestOptions);
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if(err.type == DioExceptionType.connectionError && (err.requestOptions.isOfflineApi) && !err.requestOptions.isFromQueueItem){
      handler.resolve(await OfflineHandler().handleRequest(err.requestOptions));
    }else{
      super.onError(err, handler);
    }
  }
}
