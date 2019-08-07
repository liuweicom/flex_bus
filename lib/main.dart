import 'package:flex_bus/page/login_page.dart';
import 'package:flex_bus/page/password_page.dart';
import 'package:flutter/material.dart';

import 'modal/user_info_model.dart';
import 'page/home_page.dart';

import 'package:provider/provider.dart';

///关于Provider的选择：
///Provider:只提供恒定的数据，不能通知依赖它的子部件刷新
///ListenableProvider ：此对象继承了Listenable抽象类的子类，由于无法混入，所以通过继承来获得 Listenable 的能力，同时必须实现其 addListener / removeListener 方法，手动管理收听者。ListenableProvider 同样可以接收混入的ChangeNotifier ，应为ChangeNotifier 为Listenable的实现
///ChangeNotifierProvider：自动帮我们实现了听众的管理，它能够对子节点提供一个 继承 / 混入 / 实现 了 ChangeNotifier 的类，需要数据更新的时候调用 notifyListeners。ChangeNotifierProvider 会在你需要的时候，自动调用其 _disposer 方法。 Model 中重写 ChangeNotifier 的 dispose 方法，来释放其资源。这对于复杂 Model 的情况下十分有用。
///ValueListenableProvider：提供实现了 继承 / 混入 / 实现 了 ValueListenable 的 Model，专门用于处理只有一个单一变化数据的 ChangeNotifier， ValueListenable 处理的类不再需要数据更新的时候调用 notifyListeners
///StreamProvider：用作提供（provide）一条 Single Stream，
///FutureProvider：
void main() {
  final userInfo = UserInfoModel();
  final textSize = 48;
  runApp(
  MultiProvider(//当存在多个Provider时，为了避免嵌套过多，存在多个model的时候
      providers: [
        Provider.value(value: textSize),
        ChangeNotifierProvider.value(value: userInfo),
      ],
      child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
       "login": (BuildContext context) => LoginPage(),
        "password": (BuildContext context) => PassWordPage(),
        "homePage": (BuildContext context) => HomePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),//MyHomePage(title: 'Flutter Demo Home Page')
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
