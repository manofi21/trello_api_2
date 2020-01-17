import 'package:flutter/material.dart';
import 'api_models.dart';
import 'api_provider.dart';
import 'add_edit.dart';
import 'package:http/http.dart' as http;

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  API_Providers prov;
  int banyakData;
  List<Tab> myTabs = List();
  List<ApiList> allList;
  String idList;
  GlobalKey<FormState> formKeys = new GlobalKey<FormState>();
  GlobalKey<RefreshIndicatorState> refresKeys =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    setState(() {});
    super.initState();
    prov = API_Providers();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ApiList>> allList = prov.getListsAndBoards();
    void restAgain() {
      setState(() {
        allList = prov.getListsAndBoards();
      });
    }

    return Scaffold(
        body: RefreshIndicator(
      key: refresKeys,
      onRefresh: () async {
        return restAgain();
      },
      child: FutureBuilder(
          future: allList,
          builder:
              (BuildContext context, AsyncSnapshot<List<ApiList>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('something wrong : ${snapshot.error.toString()}'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return DefaultTabController(
                  length: snapshot.data.length,
                  child: Builder(builder: (context) {
                    return Scaffold(
                        floatingActionButton: FloatingActionButton(
                          child: Icon(Icons.add_box),
                          onPressed: () {
                            int dow = DefaultTabController.of(context).index;
                            print(dow);
                            alertDialog(context, formKeys, refresKeys,
                                idList: snapshot.data[dow].id);
                          },
                        ),
                        appBar: AppBar(
                          bottom: TabBar(
                            tabs: snapshot.data.map((sub) {
                              return Tab(
                                child: Text(sub.name),
                              );
                            }).toList(),
                          ),
                        ),
                        body: TabBarView(
                          children: snapshot.data.map((sub) {
                            List<Cards> cards = sub.cards;
                            return ListView.builder(
                              itemCount: cards.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(cards[index].name),
                                  subtitle: Text(cards[index].desc),
                                );
                              },
                            );
                          }).toList(),
                        ));
                  }));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ));
  }
}
