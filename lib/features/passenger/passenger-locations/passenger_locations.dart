import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/core/resources/values_manager.dart';
import 'package:cabby/features/passenger/passenger-locations/bloc/passenger_locations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';

@RoutePage()
class PassengerLocationsScreen extends StatefulWidget {
  const PassengerLocationsScreen({super.key});

  @override
  State<PassengerLocationsScreen> createState() =>
      _PassengerLocationsScreenState();
}

class _PassengerLocationsScreenState extends State<PassengerLocationsScreen> {
  final PassengerLocationsBloc _passengerLocationsBloc =
      getIt<PassengerLocationsBloc>();

  final FocusNode _pickupLocationInputFocusNode = FocusNode();
  final FocusNode _destinationLocationInputFocusNode = FocusNode();

  InputFocus _currentInputFocus = InputFocus.destination;

  @override
  void initState() {
    _pickupLocationInputFocusNode.addListener(onFocusChange);
    _destinationLocationInputFocusNode.addListener(onFocusChange);

    super.initState();
  }

  void onFocusChange() {
    setState(() {
      if (_pickupLocationInputFocusNode.hasFocus) {
        _currentInputFocus = InputFocus.pickup;
      } else {
        _currentInputFocus = InputFocus.destination;
      }
    });
  }

  @override
  void dispose() {
    _pickupLocationInputFocusNode.dispose();
    _destinationLocationInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Routes'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s12,
          ),
          _pickupLocationInput(),
          const SizedBox(
            height: AppSize.s10,
          ),
          _destinationLocationInput(),
          const SizedBox(
            height: AppSize.s12,
          ),
          _searchResultBox(),
        ],
      ),
    );
  }

  Widget _pickupLocationInput() {
    return BlocBuilder<PassengerLocationsBloc, PassengerLocationsState>(
      builder: (context, state) {
        String pickupLocation = state.pickupLocation?.address ?? '';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
          child: TextFormField(
            focusNode: _pickupLocationInputFocusNode,
            initialValue: pickupLocation,
            onChanged: (value) {
              EasyDebounce.debounce(
                'pickup-location-input-debounce', // <-- An ID for this particular debouncer
                const Duration(milliseconds: 500), // <-- The debounce duration
                () async {
                  _passengerLocationsBloc
                      .add(LocationAutoCompleteSearch(input: value));
                },
              );
            },
            decoration: InputDecoration(
              hintText: "Search pick-up location",
              prefixIcon: _currentInputFocus == InputFocus.pickup
                  ? Icon(Icons.search, color: ColorManager.blue)
                  : Icon(Icons.adjust_outlined, color: ColorManager.primary),
              fillColor: ColorManager.whiteGrey,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSize.s11_3, horizontal: AppSize.s12),
            ),
            style: const TextStyle(
              fontSize: AppSize.s16,
            ),
          ),
        );
      },
    );
  }

  Widget _destinationLocationInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: TextFormField(
        autofocus: true,
        onChanged: (value) {
          EasyDebounce.debounce(
            'destination-location-input-debounce', // <-- An ID for this particular debouncer
            const Duration(milliseconds: 500), // <-- The debounce duration
            () async {
              _passengerLocationsBloc
                  .add(LocationAutoCompleteSearch(input: value));
            },
          );
        },
        decoration: InputDecoration(
          hintText: "Destination location",
          prefixIcon: _currentInputFocus == InputFocus.destination
              ? Icon(Icons.search, color: ColorManager.blue)
              : Icon(Icons.adjust_outlined, color: ColorManager.primary),
          fillColor: ColorManager.whiteGrey,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
              vertical: AppSize.s11_3, horizontal: AppSize.s12),
        ),
        style: const TextStyle(
          fontSize: AppSize.s16,
        ),
      ),
    );
  }

  Widget _searchResultBox() {
    return BlocBuilder<PassengerLocationsBloc, PassengerLocationsState>(
      builder: (context, state) {
        if (state.locationPredictionAutoComplete == null) {
          return const Expanded(
            child: SizedBox(),
          );
        } else if (state.locationPredictionAutoComplete!.isEmpty) {
          return const Expanded(
            child: Center(
              child: Text('No search result found'),
            ),
          );
        } else {
          print(state.locationPredictionAutoComplete);
          // return const Expanded(child: Placeholder());
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    getLocationDetails(state,
                        state.locationPredictionAutoComplete?[index]?.placeId);
                  },
                  leading: Icon(
                    _getLocationIcon(state
                        .locationPredictionAutoComplete?[index]?.locationType),
                    color: const Color(0xFF737479),
                  ),
                  title: Text(
                    state.locationPredictionAutoComplete?[index]?.mainText ??
                        '',
                    style: const TextStyle(
                      color: Color(0xFF424346),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    state.locationPredictionAutoComplete?[index]
                            ?.secondaryText ??
                        '',
                    style: const TextStyle(
                      color: Color(0xFF737479),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s14),
                  child: Divider(
                    color: Color(0xFFF1F1F1),
                    height: AppSize.s0,
                  ),
                );
              },
              itemCount: state.locationPredictionAutoComplete!.length,
              physics: const ClampingScrollPhysics(),
            ),
          );
        }
      },
    );
  }

  void getLocationDetails(PassengerLocationsState state, String? placeId) {
    print("==========Pickup Location========");
    print(_currentInputFocus);

    _passengerLocationsBloc.add(
      PassengerLocationDetails(
        placeId: placeId,
        inputFocus: _currentInputFocus,
      ),
    );
    print(state.pickupLocation?.address);
    print(state.destinationLocation?.address);

    // if (_currentInputFocus == InputFocus.pickup) {
    //   onFocusChange();
    // }
  }

  IconData _getLocationIcon(List<String>? type) {
    List<String> market = ['cafe', 'restaurant', 'food', 'store'];
    List<String> school = ['school', 'university'];
    List<String> church = [
      'church',
    ];
    List<String> mosque = ['mosque'];
    List<String> worship = ['church', 'place_of_worship', 'mosque'];

    if (type == null) {
      return Icons.place_outlined;
    } else if (type.any((element) => market.contains(element))) {
      return Icons.storefront_outlined;
    } else if (type.any((element) => school.contains(element))) {
      return Icons.school_outlined;
    } else if (type.any((element) => church.contains(element))) {
      return Icons.church_outlined;
    } else if (type.any((element) => mosque.contains(element))) {
      return Icons.mosque_outlined;
    } else if (type.any((element) => worship.contains(element))) {
      return Icons.synagogue_outlined;
    }
    return Icons.place_outlined;
  }
}

enum InputFocus { pickup, destination }
