# flex_bus出行需求分析：
## 弹性公交
功能点：
1. 申诉违约（违约原因，客服电话）
2. 我的订单

- 点击订单可以快速预约
- 订单详情（起点，终点，状态【已完成，已取消】，返回按钮）
3. 搜索目的地：就近填写当前地点，目的地默认搜索当前附近站点，点击预约之后
4. 弹出乘客须知（附近站点上车，或者对面上车，车辆未派车之前可以取消）
5. 预约成功之后，状态栏给出提示【起点-终点，预计还有多长时间可以上车，此时，地图显示线路，显示当前车辆位置】
## 预约公交

## 车载端需求
1. 司机绑定（绑定车牌，解绑车牌）
2. 确认发车：显示订单详情，线路，途径的站点，司机信息
3. 发车之后：下一站，（确认到站），订单详情（起点，终点，乘客号码，人数），上下车人数，确认线路结束
4. 隐藏的功能点：地图显示线路，导航功能，走过的线路隐藏，到站语音提示，新订单语音提示，下一站语音提示，途径站点，定位

## 隐含需求
1. 个人中心：用户反馈，关于我们，退出功能，身份认证，人脸登陆，
2. 登陆页面手机号码注册（注册）
3. 支付模块
4. 切换城市
5. 搜索地理位置
6. 历史订单

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

添加插件报错之后报错了
````
Error:Execution failed for task ':app:transformDexArchiveWithExternalLibsDexMergerForDebug'.

> java.lang.RuntimeException: java.lang.RuntimeException:

com.android.builder.dexing.DexArchiveMergerException: Unable to merge dex。
````
解决办法：
在app的build.gradle中添添加
 build.gradle 文件中的 defaultConfig 配置中添加配置：
````
defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.flex_bus"
        minSdkVersion 17
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
   +     multiDexEnabled true
    }
````

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
