import 'dart:async';
import 'dart:convert';

import 'package:birdie/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ContactProvider with ChangeNotifier {

  late Future fetchFromAWS;
  List<String> contactNameList = [], number = [], lastMessageSent = [];

  Future<void> deleteContact({required String contactName, userName}) async {
    var url =
        'https://birdie-auth-testing.herokuapp.com/api/users/$userName/deletecontact';

    var chosenContact = json.encode({'name': contactName});

    await http
        .delete(Uri.parse(url),
            headers: {'Content-Type': 'application/json'}, body: chosenContact)
        .then((value) {
      if (value.statusCode == 200) {
        debugPrint('Deleted contact: $contactName');
        
          debugPrint('$contactNameList before');
          contactNameList.remove(contactName);
          debugPrint('$contactNameList after');
          // fetchFromAWS = fetchData();
        
      }
    });
  }


Future<void> fetchData(String userName) async {
    debugPrint('Fetching user $userName data');

    var request = await http.get(Uri.parse(
        //  'localhost:3000/api/getcontacts' // ! API HEROKU URL
        'https://birdie-auth-testing.herokuapp.com/api/users/$userName/getcontacts'));
    var response = await json.decode(request.body);

    // var test = response[0]['content'];

    // debugPrint('Last message sent: $test');

    
      contactNameList.clear();
      lastMessageSent.clear();
      if (contactNameList.isEmpty && number.isEmpty) {
        // ? Recent fix
        for (int i = 0; i < response.length; i++) {
          contactNameList.add(response[i]['name']);
          lastMessageSent.add(response[i]['content'] ?? '<empty>');
        }
        // debugPrint('\nResponse body: ${response.toString()}');
        // debugPrint('Recent messages: ${name.toString()}');
        debugPrint('Found ${contactNameList.length} contacts for user $userName');
        debugPrint('Recent messages: $lastMessageSent');
      }

      if (contactNameList.last != response[response.length - 1]['name']) {
        contactNameList.add(response[response.length - 1]['name']);
      }
    
  }

 


}
