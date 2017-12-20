library upload_files.client;

import 'package:http/http.dart' as http;

import 'package:form_example/model.dart';

main() async {
  final api = new Api(new http.IOClient(), host: 'http://localhost:8005');

  await api.add('Lucifer', 'Morningstart', '+66666666666');
  print(await api.get());
}
