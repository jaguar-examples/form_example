import 'dart:async';
import 'dart:html';
import 'package:http/browser_client.dart' as http;
import 'package:jaguar_client/jaguar_client.dart';
import 'package:stencil/stencil.dart';

import 'package:form_example/model.dart';

JsonClient client = new JsonClient(new http.BrowserClient());

DivElement contactsHolder;

class ContactComp extends Component {
  final Contact contact;

  ContactComp(this.contact);

  String render() {
    return '''
<div class="item">
  <div>
    <span>First name</span>
    <span>${contact.firstName}</span>
  </div>
  <div>
    <span>Last name</span>
    <span>${contact.lastName}</span>
  </div>
  <div>
    <span>Phone number</span>
    <span>${contact.phoneNumber}</span>
  </div>
</div>
    ''';
  }
}

class ContactListComp extends Component {
  final List<Contact> contacts;

  ContactListComp(this.contacts);

  String render() {
    return '''
<div>
  ${forEach(contacts, (contact) => comp(new ContactComp(contact)))}
</div>
    ''';
  }
}

final api = new Api(new http.BrowserClient());

Future updatePics() async {
  contactsHolder.setInnerHtml(new ContactListComp(await api.get()).render());
}

main() async {
  final ButtonElement refreshBtn = querySelector("#refresh-btn");
  contactsHolder = querySelector("#contacts-holder");

  refreshBtn.onClick.listen((_) async {
    await updatePics();
  });

  new Future.delayed(new Duration(seconds: 1)).then((_) {
    updatePics();
  });
}
