import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class FlexPage extends StatefulWidget {
  @override
  _FlexPageState createState() => _FlexPageState();
}

class _FlexPageState extends State<FlexPage> with AutomaticKeepAliveClientMixin{
  AMapController _controller;
  MyLocationStyle _myLocationStyle = MyLocationStyle();
  final _amapLocation = AMapLocation();
  @override
  void initState() {
    _amapLocation.init();
//    _getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _amapLocation.stopLocate();
    // TODO: implement dispose
    super.dispose();
  }
  void _updateMyLocationStyle(
      BuildContext context, {
        String myLocationIcon,
        double anchorU,
        double anchorV,
        Color radiusFillColor,
        Color strokeColor,
        double strokeWidth,
        int myLocationType,
        int interval,
        bool showMyLocation,
        bool showsAccuracyRing,
        bool showsHeadingIndicator,
        Color locationDotBgColor,
        Color locationDotFillColor,
        bool enablePulseAnnimation,
        String image,
      }) async {
    if (await Permissions().requestPermission()) {
      _myLocationStyle = _myLocationStyle.copyWith(
        myLocationIcon: myLocationIcon,
        anchorU: anchorU,
        anchorV: anchorV,
        radiusFillColor: radiusFillColor,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        myLocationType: myLocationType,
        interval: interval,
        showMyLocation: showMyLocation,
        showsAccuracyRing: showsAccuracyRing,
        showsHeadingIndicator: showsHeadingIndicator,
        locationDotBgColor: locationDotBgColor,
        locationDotFillColor: locationDotFillColor,
        enablePulseAnnimation: enablePulseAnnimation,
        image: image,
      );
      _controller.setMyLocationStyle(_myLocationStyle);
    } else {
      print('权限不足');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: Stack(
              children: <Widget>[
                AMapView(
                  onAMapViewCreated: (controller) {
                    _controller = controller;
                  },
                  amapOptions: AMapOptions(
                    compassEnabled: true,
                    zoomControlsEnabled: true,
                    logoPosition: LOGO_POSITION_BOTTOM_CENTER,
                      myLocationEnabled: true
//                    camera: CameraPosition(
//                      target: LatLng(40.851827, 111.801637),
//                      zoom: 15,
//                    ),
                  ),
                ),
                Positioned(
                left: 10,
                bottom: 20,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.my_location,
                        size: 26,
                        color: Colors.black,
                      ),
                      onTap: (){
                        _getOnceLocation();
                        print("location=====");
//                        Scaffold.of(context).showSnackBar(SnackBar(
//                          content: Text('定位间隔5秒'),
//                          duration: Duration(seconds: 1),
//                        ));
//                        //interval: 5000,
//                        _updateMyLocationStyle(context, showMyLocation: true,myLocationIcon: "location_on");//, myLocationIcon: "location_on",myLocationType: LOCATION_TYPE_FOLLOW
                      },
                    ),

                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getOnceLocation()async{
    final options = LocationClientOptions(
      isOnceLocation: true,
      locatingWithReGeocode: true,
    );

    if (await Permissions().requestPermission()) {
    _amapLocation
        .getLocation(options)
        .then((data){
//          LocationMode locationMode = data as LocationMode;
          print(data.toString()+"onceLocation======");
        })
        .then((_) => print("-------:"+_.toString()));
    } else {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('权限不足')));
    }
  }

  _getLocation()async{
    final options = LocationClientOptions(
      isOnceLocation: false,
      locatingWithReGeocode: true,
        interval: 100
    );

    if (await Permissions().requestPermission()) {
    _amapLocation
        .startLocate(options)
        .map((locations){
          print(locations.toString()+"location========");
        })
        .listen((_) => setState(() {}));
    } else {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('权限不足')));
    }
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
