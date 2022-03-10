import 'package:smart_taal_system/backend/enumeratorRawData.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "smart-taal-system",
  "private_key_id": "9985da5c50cc355dff2f55f67d38d2632a7f655d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrDoDfSaQRqDIE\ntbU9oc+Z97zkWrxSyv/vSOnNtSRKWbgyKQ9ZPYro2a3T4jPCIMWW40uOR2EvV0lI\nXooeyaU/VmEslHq4B553XqoiJ0t10qwsCCB3E2jHqXgg31EzxrgdPgE/ztnBumbd\nDqCODBQRMbskBBZDpmF6HW0bqeFM3HFw1NmJs0gF403tH9l2TUoXPDru8epcXcOu\nzjgSiTIVpNcVI9HC0oHyyabfR+csiFqHW+K9s9eoLhDRd5gRS7ooFV3c76zhrMlC\neu1Sv60GpKdaV5cx6JcYVq8+dmr9N1XZ3/yikLRxYP8YfI5zaXKNZdCYukVhJpXm\nQgRUC2ifAgMBAAECggEATziYVtE0Ozk6cRP2rGSUUSp7QQcE0RNTFO8f2TVbaVPE\nCvcZNKtb+htWdhr8/ZtP52G9TFeimtpCBlJChZ+9+Gd4+byKWVCuA3rEMK0iNZ8s\nPfhFkOBcVpwWFqNWaDRQcLqWuYaDM0Ww/hAYK7FMWeo+UZ/S7+HOo0+diIJU5dMv\nEnG1+95+QfZ0QtiKm6C1jXM/KGUJAWrqvjv4KTp9U/uGbhoftU1+7HWaWWAUDqZs\nk4mpMhIqPdMSTiqUILGhritzNofquS5+Qncnq2QWAmI7xx8jaaKALCERzDXusFuO\ne0B2NKL7EpCF1Ix2I1thPBj2aAKyIM1FnYZ61tkygQKBgQDtiNgrOjkyKE10rpta\nQZRNrgNkkHYAlExwbJDErugd0YQfCd1e+or4bNlaIgFu1vI+vWRcA3MXQKg8Yz2F\n6+xRurxhsMyxq3/xCFYMKGuXGhK478HIpsECB++L3l3cvjAUZQ4+nHugWBB2grLQ\njEf/SOE79uX3oo5X6fOjhdoQwwKBgQC4WrAX3JjEwb70sg/JZKtYmOuKKL0VC8eK\nPbrmdSZ9RSH7CG/C8orXcLaeZIZ1Pb8scE67QlJTf/irzNpfPgUbPMoyRUdFsdi1\nRFrGJ2U2ZHiThCIzaYCRBvIncmJIBOnYrYHW8k1a5pxN+VyctOqfMsDh0LcRqYwt\nbjyhEGtK9QKBgQCB0A+TUDaB2tS5t9Le+If8C+V+yBQ1LNa5ehuD4bKo2R/Ddris\nd3ALZDFEuODfmki5UPfP8XKseoF2vyWYUt7Lq6nYGa9ESd2Z9FxSOKTT50PkHeNh\nrQA+A+g+IEBbqvTLsI6gWRSXBIm6uqLOpluSgFnXU49KTmRMV2b3LueF0QKBgGAQ\n6ehVTMpjB8XtL+rLabqOXVcuaXGZJM714foLnBX1O4Lb35lf2Ffx5UferG5V0dQv\nZeeQ5OOcMRIdesHcyL5rzBWsIjrANWQoDYFqsARLEMYWOdg+pv9r9i32Hh7XaKA/\nsgQ3WXX/6/157ve+EvEIephxsaQjjOdzpWZs7uwtAoGAMvQBuyLuGEf2ffvnTEjA\nB5Xaq6ANC1BMMBrx8sCyCjul+y5jzZhU9uNp5NipcztCX/VIm+VNZy/oZsx7xIkO\n/J39DswoqqpWHaOWr3zeJaJMXeWIe3UUtMmWdRQJXX9TqIWea7974ZIxTOLyhRZb\n4wWzqPOji6m8QZCkecaQ54o=\n-----END PRIVATE KEY-----\n",
  "client_email": "smart-taal-system@smart-taal-system.iam.gserviceaccount.com",
  "client_id": "104441340578384226891",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/smart-taal-system%40smart-taal-system.iam.gserviceaccount.com"
}
''';
  //connect with spreadsheet
  static const _spreadsheetId = '1H1U81y0TtxiAnpEYQAdob9cHZo0hxM4m3fPQf1BCINM';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorksheet(spreadsheet, title: 'enumeratorRawData');
      final firstRow = EnumeratorRawDataColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorksheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }

  String uuid = '';
  static Future queryGSheets({uuid}) async {
    print(await _userSheet!.values.map.rowByKey(uuid));
  }

  static Future deleteByUuid({uuid}) async {
    if (_userSheet == null) return false;
    final index = await _userSheet!.values.rowIndexOf(uuid);
    return _userSheet!.deleteRow(index);
  }

  static Future<bool> update({uuid, row}) async {
    if (_userSheet == null) return false;
    return _userSheet!.values.map.insertRowByKey(uuid, row);
  }

//   static Future<bool> update(
//     int id,
//     Map<String, dynamic> user,
//   )async{
// if(_userSheet == null) return false;
// return _userSheet!.values.map.insertRowByKey(id,user);
//   }

//   // static Worksheet? _worksheet;

//   // //initializing spreadsheet
//   // Future init() async {
//   //   final ss = await _gsheets.spreadsheet(_spreadsheetId);
//   //   _worksheet = ss.worksheetByTitle('Sheet3');
//   // }

//   // //inserting data
//   // static Future insert(String data) async {
//   //   if (_worksheet == null) return;
//   //   await _worksheet!.values.appendRow([data]);
//   // }
}
