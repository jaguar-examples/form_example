import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:jaguar_client/jaguar_client.dart';

class Contact {
  final int id;

  final String firstName;

  final String lastName;

  final String phoneNumber;

  Contact({this.id, this.firstName, this.lastName, this.phoneNumber});

  static int _genId = 0;

  static Contact create(Map<String, String> map) => new Contact(
      id: _genId++,
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber']);

  static Contact fromMap(Map<String, dynamic> map) => new Contact(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber']);

  Map<String, dynamic> get toMap => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
  };

  String toString() => toMap.toString();
}

class Api {
  final JsonClient client;

  final String host;

  Api(http.Client client, {this.host: ''}) : client = new JsonClient(client);

  /// Add a new contact
  Future<List<Contact>> add(
      String firstName, String lastName, String phoneNumber) async {
    final JsonResponse resp = await client.postForm('$host/api/add', body: {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    });
    print(resp.body);
    return (resp.body as List<Map<String, dynamic>>)
        .map(Contact.fromMap)
        .toList();
  }

  /// Get all contacts
  Future<List<Contact>> get() async {
    final JsonResponse resp = await client.get('$host/api/read');
    return (resp.body as List<Map<String, dynamic>>)
        .map(Contact.fromMap)
        .toList();
  }
}