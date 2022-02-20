import 'package:internet_connection_checker/internet_connection_checker.dart';

checkConnection(Function connected, Function notConnected) async {
  bool isConnected = await InternetConnectionChecker().hasConnection;
  if (isConnected == true) {
    connected;
  } else {
    notConnected;
  }
}
