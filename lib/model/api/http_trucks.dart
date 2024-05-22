import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../globals.dart';

class HttpTrucks {
  HttpTrucks._();
  static final HttpTrucks instance = HttpTrucks._();

  final client = http.Client();

  Future<String> getTrucks() async {
    final response = await http.get(
        Uri.https( apiUrl, 'truck' ),
        headers: { 'Authorization': 'Bearer ${auth.token}' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<String> getTruckByOperator(String operator) async {
    final response = await http.get(
        Uri.https( apiUrl, 'truck/operator/$operator' ),
        headers: { 'Authorization': 'Bearer ${auth.token}' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Stream<String> fetchLocation(StreamedResponse response) async* {
    //final url = Uri.parse('https://$apiUrl/truck/streaming/${auth.truck.id}/location');

    //final request = http.Request('GET', url);
    //final response = await client.send(request);

    // Escucha los datos en tiempo real
    // response.stream.transform(utf8.decoder).listen((data) {
    //   final parsedData = json.decode(data);
    //   // Haz algo con los datos recibidos (por ejemplo, actualiza la ubicación en tu aplicación)
    //   print(parsedData);
    // });
    await for (final data in response.stream.transform(utf8.decoder)) {
      final dataString = data.toString().split('\n')[1];

      //print(dataString.split(' ').last);
      //final string1 = dataString.replaceFirst(RegExp(r'd'), "\"");
      //final string2 = string1.replaceFirst(RegExp(r':'), "\"");
      //final string3 = string2.replaceFirst(RegExp(r' '), ":");
      //print(dataString.replaceFirst(RegExp(r':'), "\""));
      //print(dataString.replaceFirst(RegExp(r' '), ":"));
      //print(dataString.split(' '));
      //final objectString = dataString.split(' ');
      /*try {
        print(dataString.toString().split(' ')[2]);
      } on Exception catch (e) {
        print(e.toString());
      }*/
      final json = dataString.split(' ').last;

      yield json;
    }
  }

}