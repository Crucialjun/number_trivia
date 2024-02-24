import 'package:get_it/get_it.dart';
import 'package:number_trivia/services/network_service/i_network_service.dart';
import 'package:number_trivia/services/network_service/network_service.dart';

final locator = GetIt.instance;

Future setUpLocator() async {
  locator.registerLazySingleton<INetworkService>(() => NetworkService());
}
