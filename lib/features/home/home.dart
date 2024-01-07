import 'package:auto_route/auto_route.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/widgets/app_drawer.dart';
import 'package:cabby/core/widgets/location_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocationAppBar(
        context: context,
        enableLocationAppbar: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(51.509364, -0.128928),
              initialZoom: 9.2,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/kiisi/clqur40uz001n01pd8iez9fde/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2lpc2kiLCJhIjoiY2xxbmpheHV6M2hiOTJpcHJnZDhpc2Z6ZyJ9.kx-fmGwpqLP_DJk9Ja4dLg',
                userAgentPackageName: 'com.cabby.app',
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Builder(
              builder: (context) => IconButton(
                color: ColorManager.blueLight,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorManager.white),
                  elevation: const MaterialStatePropertyAll(8.0),
                ),
                constraints: const BoxConstraints(minHeight: 52, minWidth: 52),
                highlightColor: const Color(0xFFE4E4E4),
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu_rounded),
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: ColorManager.white,
          foregroundColor: ColorManager.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {},
          child: const Icon(Icons.my_location),
        ),
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            child: const Center(
              child: Text(
                'Persistent Bottom Sheet Content',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
