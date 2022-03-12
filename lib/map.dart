import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:projecttermapp/Drawer.dart';

void main() {
  runApp(const pageMap());
}

class pageMap extends StatelessWidget {
  const pageMap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Mapping(),
    );
  }
}

class Mapping extends StatefulWidget {
  const Mapping({Key? key}) : super(key: key);

  @override
  State<Mapping> createState() => _MappingState();
}

class _MappingState extends State<Mapping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widgetDrawer(),
      appBar: new AppBar(
        title: new Text('Map'),
      ),
      body: new FlutterMap(
        options:  MapOptions(
          minZoom: 10.0 ,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/izeza555/cl0m2foqx006m14ld2rz4zp7l/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXplemE1NTUiLCJhIjoiY2wwbDVjeHV2MHRmZTNsb2FpazQ4cDA4MSJ9.QjBnCTej3FmhMbrUvQhL2w",
              additionalOptions: {
                "accessToken":
                    "pk.eyJ1IjoiaXplemE1NTUiLCJhIjoiY2wwbDVjeHV2MHRmZTNsb2FpazQ4cDA4MSJ9.QjBnCTej3FmhMbrUvQhL2w",
                "id": "mapbox://styles/izeza555/cl0m2foqx006m14ld2rz4zp7l"
              })
        ],
      ),
    );
  }
}
