import 'package:flutter/material.dart';
import 'package:myapp/launch_url.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _str = "test";
  static const _url = "https://jsonplaceholder.typicode.com/todos/1";
  final List<Map<String, dynamic>> listItems = [
    {
      'text': 'Item 1',
      'color': Colors.blue[600],
    },
    {
      'text': 'Item 2',
      'color': Colors.blue[300],
    },
    {
      'text': 'Item 3',
      'color': Colors.blue[100],
    },
    {
      'text': 'Item 4',
      'color': Colors.blue[50],
    },
    {
      'text': 'Item 5',
      'color': Colors.blue[25],
    },
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: Icon(Icons.arrow_back),
        // タイトルテキスト
        title: Text(widget.title),
        // 右側のアイコン一覧
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_str, style: TextStyle(color: Colors.orange, fontSize: 20)),
            Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text('リクエスト'),
                    // ボタンをクリックした時の処理
                    onPressed: () async {
                      Uri uri = Uri.parse(_url);
                      http.Response res = await http.get(uri);
                      setState(() => _str = res.body);
                    })),
            Container(
              height: 200,
              padding: EdgeInsets.all(4),
              // 配列を元にリスト表示
              child: ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    color: listItems[index]['color'],
                    child: Text(listItems[index]['text']),
                  );
                },
              ),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: launchURL,
        tooltip: 'Increment',
        child: Icon(Icons.flight),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
