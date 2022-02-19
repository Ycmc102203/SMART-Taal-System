import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import 'package:smart_taal_system/widgets/calendar.dart';
import '../widgets/days_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
            color: Colors.purple,
            child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      _checkConnection();
                    });
                    ;
                  });
                },
                child: RawScrollbar(
                    thumbColor: Colors.green,
                    radius: Radius.circular(10),
                    thickness: 7,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(children: [
                          Calendar(),
                          ActivitiesList(),
                        ]))))));
    // Scaffol
  }
}

void _checkConnection() async {
  // Simple check to see if we have internet
  print("The statement 'this machine is connected to the Internet' is: ");
  print(await InternetConnectionChecker().hasConnection);
  // returns a bool

  // We can also get an enum value instead of a bool
  print(
      "Current status: ${await InternetConnectionChecker().connectionStatus}");
  // prints either InternetConnectionStatus.connected
  // or InternetConnectionStatus.disconnected

  // This returns the last results from the last call
  // to either hasConnection or connectionStatus
  print("Last results: ${InternetConnectionChecker().isActivelyChecking}");

  // actively listen for status updates
  // this will cause InternetConnectionChecker to check periodically
  // with the interval specified in InternetConnectionChecker().checkInterval
  // until listener.cancel() is called
  var listener = InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        print('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        break;
    }
  });

  // close listener after 30 seconds, so the program doesn't run forever
  await Future.delayed(Duration(seconds: 30));
  await listener.cancel();
}
