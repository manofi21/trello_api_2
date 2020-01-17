import 'package:http/http.dart' as http;
import 'api_models.dart';
  
final String apiKey = 'a55fbe346c035679d1887e21b50203ae';
final String idList = '5e14033a82d6382e252b6467';
final String apiToken =
      'f589754ce493d3f89e37b35dd47bc5f3ae339fd96f050a61a504c7af183ef2ab';
class API_Providers{
  final baseUrl = 'https://api.trello.com/1';
  final authorization = 'key=${apiKey}&token=${apiToken}';

  // Future<List<ApiList>> getBoards() async {
  //   final d = 'https://api.trello.com/1/boards/oy5du8zO/cards?fields=name,desc&key=a55fbe346c035679d1887e21b50203ae&token=f589754ce493d3f89e37b35dd47bc5f3ae339fd96f050a61a504c7af183ef2ab';
  //   final response = await http.get(d);
  //       //'${baseUrl}/boards/oy5du8zO/cards?fields=name,desc&${authorization}'
  //   if (response.statusCode == 200) {
  //     return apiListFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<List<ApiList>> getLists() async {
  //   final d = 'https://api.trello.com/1/boards/oy5du8zO/lists?cards=none&card_fields=all&filter=open&fields=all&key=a55fbe346c035679d1887e21b50203ae&token=f589754ce493d3f89e37b35dd47bc5f3ae339fd96f050a61a504c7af183ef2ab';
  //   final response = await http.get(d);
  //       //'${baseUrl}/boards/oy5du8zO/cards?fields=name,desc&${authorization}'
  //   if (response.statusCode == 200) {
  //     return apiListFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  Future<List<ApiList>> getListsAndBoards() async {
    final d = 'https://trello.com/1/boards/oy5du8zO/lists?cards=open&card_fields=name,desc&filter=open&fields=name&${authorization}';
    final response = await http.get(d);
        //'${baseUrl}/boards/oy5du8zO/cards?fields=name,desc&${authorization}'
    if (response.statusCode == 200) {
      return apiListFromJson(response.body);
    } else {
      return null;
    }
  }

  //https://api.trello.com/1/boards/oy5du8zO/cards?fields=name,desc&key=a55fbe346c035679d1887e21b50203ae&token=f589754ce493d3f89e37b35dd47bc5f3ae339fd96f050a61a504c7af183ef2ab

  Future<bool> createCard(Cards models,String idList) async{
    final response = await http.post(
      '${baseUrl}/cards?name=${models.name}&desc=${models.desc}&' +
        'idList=${idList}&keepFromSource=all&${authorization}',
        headers: {'content-style': 'application/json'}
    );
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }
  
  Future<bool> updateCard(Cards models) async{
    final response = await http.put(
      '${baseUrl}/cards/${models.id}?name=${models.name}&desc=${models.desc}&${authorization}',
      headers: {'content-style': 'application/json'}
    );
    //https://api.trello.com/1/cards/4VwwOQKx?name=ppp&desc=pura&key=a55fbe346c035679d1887e21b50203ae&token=f589754ce493d3f89e37b35dd47bc5f3ae339fd96f050a61a504c7af183ef2ab
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> deleteCard(Cards models) async{
    final response = await http.delete('${baseUrl}/cards/${models.id}?${authorization}',
          headers: {'content-style': 'application/json'}
    );
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    } 
  }

}