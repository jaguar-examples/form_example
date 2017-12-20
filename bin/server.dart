import 'package:jaguar/jaguar.dart';
import 'package:jaguar_dev_proxy/jaguar_dev_proxy.dart';
import 'package:jaguar_static_file/jaguar_static_file.dart';

import 'package:form_example/model.dart';

final List<Contact> contacts = [];

main(List<String> arguments) async {
  final server = new Jaguar(port: 8005);

  server.group('/api')

    // Route to save data
    ..post('/add', (ctx) async {
      final Map<String, String> map = await ctx.req.bodyAsUrlEncodedForm();
      contacts.add(Contact.create(map));
      return Response.json(contacts.map((ct) => ct.toMap).toList());
    })

    // Route to retrieve data
    ..get('/read',
        (ctx) => Response.json(contacts.map((ct) => ct.toMap).toList()));

  // Proxy all html client requests to pub server
  server.addApi(new PrefixedProxyServer('/', 'http://localhost:8000/'));
  // TODO server.addApi(new StaticFileHandler('/data/img/', new Directory('bin/data')));

  await server.serve();
}
