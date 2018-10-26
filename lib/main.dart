import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  static const platform = const MethodChannel(
      'flutter.rortega.com.channel');

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "RestApi",
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  List<String> observableStrings = List();
  String url = "https://swapi.co/api/starships";
  List data;

  Future<List> getData1() async{
    var result = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});


      var resultBody = json.decode(result.body);
      data = resultBody["results"];

    return data;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(title: new Text('Rest Api')),

     /* body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTodoList(),
            new RaisedButton(
              child: new Text('Show native view'),
              onPressed: _showNativeView,
            ),
          ],
        ),
      ),*/
     body: _buildTodoList(),
    );

  }

  Future<Null> _showNativeView() async{

    await MyApp.platform.invokeMethod('showNativeView');

  }

  Widget _buildTodoList() {

    return new ListView.builder(
      itemCount: data != null ? data.length : 0,
      itemBuilder: (context, index) {
          return _buildTodoItem(data[index]["name"], index);
      },
    );
  }

  void onError(){

  }

  void onData(List data1){
    for(var i=0;i<data.length;i++){
      setState(() {
        data= data1;
      //  observableStrings.add(data[i]['name']);
        });
    }
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(title: new Text(todoText), onTap: () => {});
  }

  @override
  void initState() {
    super.initState();

    var observable = Observable.fromFuture(getData1());
    observable.listen(onData);
    //this.getData1();
  }
}
