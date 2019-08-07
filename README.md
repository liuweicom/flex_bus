# flex_bus

A new Flutter project.

## Getting Started

## 全局共享数据之Provider
参考:
- [Flutter | 状态管理指南篇——Provider](https://juejin.im/post/5d00a84fe51d455a2f22023f#heading-18)

1. 关于Provider的选择：
- Provider:只提供恒定的数据，不能通知依赖它的子部件刷新
- ListenableProvider ：此对象继承了Listenable抽象类的子类，由于无法混入，所以通过继承来获得 Listenable 的能力，同时必须实现其 addListener / removeListener 方法，手动管理收听者。ListenableProvider 同样可以接收混入的ChangeNotifier ，应为ChangeNotifier 为Listenable的实现
- ChangeNotifierProvider：自动帮我们实现了听众的管理，它能够对子节点提供一个 继承 / 混入 / 实现 了 ChangeNotifier 的类，需要数据更新的时候调用 notifyListeners。ChangeNotifierProvider 会在你需要的时候，自动调用其 _disposer 方法。 Model 中重写 ChangeNotifier 的 dispose 方法，来释放其资源。这对于复杂 Model 的情况下十分有用。
- ValueListenableProvider：提供实现了 继承 / 混入 / 实现 了 ValueListenable 的 Model，专门用于处理只有一个单一变化数据的 ChangeNotifier， ValueListenable 处理的类不再需要数据更新的时候调用 notifyListeners
- StreamProvider：用作提供（provide）一条 Single Stream，
- FutureProvider：
2. 顶层初始化共享数据
1，使用嵌套的方式组合多个Provider,

````
void main() {
  final userInfo = UserInfoModel();
  final textSize = 48;
  runApp(
        Provider<Object>.value(//能够管理一个恒定的数据，并提供给子孙节点使用
            value: textSize,
            child: ChangeNotifierProvider.value(//不仅能够提供数据供子孙节点使用，还可以在数据改变的时候通知所有听众刷新
                value: userInfo,
                child: MyApp(),
             )
       ),
  );
}

````
2,如何优雅的处理多个Provider
````
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
````
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
