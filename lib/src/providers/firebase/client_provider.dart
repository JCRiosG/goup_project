import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_up/src/models/client.dart';

class ClientProvider{
  CollectionReference? _ref;
  ClientProvider(){
    _ref = FirebaseFirestore.instance.collection('Clients');
  }
  Future<void>? create(Client client){
    String? errorMessage;
    try{
      return _ref?.doc(client.id).set(client.toJson());
    }catch(error){
      errorMessage = error.toString();
    }

    if(errorMessage != null){
      return Future.error(errorMessage);
    }
  }
}