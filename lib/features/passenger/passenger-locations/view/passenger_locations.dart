import 'package:auto_route/auto_route.dart';
import 'package:cabby/app/di.dart';
import 'package:colorful_progress_indicators/colorful_progress_indicators.dart';
import 'package:cabby/core/common/loading_status.dart';
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

  final TextEditingController _pickupLocationTextEditingController =
      TextEditingController();

  final TextEditingController _destinationLocationTextEditingController =
      TextEditingController();

  InputFocus _currentInputFocus = InputFocus.destination;

  @override
  void initState() {
    _pickupLocationInputFocusNode.addListener(onFocusChange);
    _destinationLocationInputFocusNode.addListener(onFocusChange);

    _pickupLocationTextEditingController.text =
        _passengerLocationsBloc.state.pickupLocation?.address ?? '';
    _destinationLocationTextEditingController.text =
        _passengerLocationsBloc.state.destinationLocation?.shortAddress ?? '';

    _pickupLocationTextEditingController.addListener(() {
      _passengerLocationsBloc.add(
        LocationsInputUpdater(
          input: _pickupLocationTextEditingController.text,
          inputFocus: InputFocus.pickup,
        ),
      );
    });

    _destinationLocationTextEditingController.addListener(() {
      _passengerLocationsBloc.add(
        LocationsInputUpdater(
          input: _destinationLocationTextEditingController.text,
          inputFocus: InputFocus.destination,
        ),
      );
    });

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

    _pickupLocationTextEditingController.dispose();
    _destinationLocationTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PassengerLocationsBloc, PassengerLocationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Routes'),
            backgroundColor: ColorManager.primary,
            foregroundColor: ColorManager.white,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: AppSize.s12,
              ),
              _pickupLocationInput(context, state),
              const SizedBox(
                height: AppSize.s10,
              ),
              _destinationLocationInput(context, state),
              const SizedBox(
                height: AppSize.s12,
              ),
              state.locationDetailsLoadingStatus == LoadingStatus.loading
                  ? ColorfulLinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: Colors.blue[100],
                      colors: [
                        ColorManager.primary,
                      ],
                      duration: const Duration(milliseconds: 500),
                      initialColor: ColorManager.primary,
                    )
                  : const SizedBox(
                      height: 2,
                    ),
              const SizedBox(
                height: AppSize.s12,
              ),
              _searchResultBox(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _pickupLocationInput(context, PassengerLocationsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: TextFormField(
        focusNode: _pickupLocationInputFocusNode,
        controller: _pickupLocationTextEditingController,
        onChanged: (value) {
          _passengerLocationsBloc.add(
            LocationsInputUpdater(
              input: value,
              inputFocus: InputFocus.pickup,
            ),
          );
          EasyDebounce.debounce(
              'pickup-location-input', // <-- An ID for this particular debouncer
              const Duration(milliseconds: 500), () {
            _passengerLocationsBloc.add(
              LocationAutoCompleteSearch(
                input: value,
                inputFocus: InputFocus.pickup,
              ),
            );
          });
        },
        decoration: InputDecoration(
          hintText: "Search pick-up location",
          prefixIcon: _currentInputFocus == InputFocus.pickup
              ? Icon(Icons.search, color: ColorManager.blue)
              : Icon(Icons.adjust_outlined, color: ColorManager.primary),
          fillColor: ColorManager.whiteGrey,
          filled: true,
          suffixIcon: _currentInputFocus == InputFocus.pickup
              ? GestureDetector(
                  onTap: () {
                    _pickupLocationTextEditingController.clear();
                    _passengerLocationsBloc
                        .add(PassengerLocationsPickupDiscard());
                  },
                  child: const Icon(Icons.highlight_off, size: 20),
                )
              : null,
          suffixIconColor: const Color(0xFFB3B9BD),
          contentPadding: const EdgeInsets.symmetric(
              vertical: AppSize.s11_3, horizontal: AppSize.s12),
        ),
        style: const TextStyle(
          fontSize: AppSize.s16,
        ),
      ),
    );
  }

  Widget _destinationLocationInput(context, PassengerLocationsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: TextFormField(
        autofocus: true,
        controller: _destinationLocationTextEditingController,
        onChanged: (value) {
          EasyDebounce.debounce(
            'destination-location-input',
            const Duration(milliseconds: 500),
            () async {
              _passengerLocationsBloc.add(LocationAutoCompleteSearch(
                  input: value, inputFocus: InputFocus.destination));
            },
          );
        },
        decoration: InputDecoration(
          hintText: "Destination location",
          prefixIcon: _currentInputFocus == InputFocus.destination
              ? Icon(Icons.search, color: ColorManager.blue)
              : Icon(Icons.adjust_outlined, color: ColorManager.primary),
          fillColor: ColorManager.whiteGrey,
          suffixIcon: _currentInputFocus == InputFocus.destination
              ? GestureDetector(
                  onTap: () {
                    _destinationLocationTextEditingController.clear();
                    _passengerLocationsBloc
                        .add(PassengerLocationsDestinationDiscard());
                  },
                  child: const Icon(Icons.highlight_off, size: 20),
                )
              : null,
          suffixIconColor: const Color(0xFFB3B9BD),
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

  Widget _searchResultBox(context, state) {
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
      return Expanded(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                getLocationDetails(
                    state,
                    state.locationPredictionAutoComplete?[index]?.placeId,
                    context);
              },
              leading: Icon(
                _getLocationIcon(
                    state.locationPredictionAutoComplete?[index]?.locationType),
                color: const Color(0xFF737479),
              ),
              title: Text(
                state.locationPredictionAutoComplete?[index]?.mainText ?? '',
                style: const TextStyle(
                  color: Color(0xFF424346),
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                state.locationPredictionAutoComplete?[index]?.secondaryText ??
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
  }

  void getLocationDetails(
      PassengerLocationsState state, String? placeId, BuildContext context) {
    _passengerLocationsBloc.add(
      PassengerLocationDetails(
        placeId: placeId,
        inputFocus: _currentInputFocus,
        context: context,
      ),
    );
  }

  IconData _getLocationIcon(List<String>? type) {
    List<String> market = ['cafe', 'restaurant', 'food', 'store'];
    List<String> school = ['school', 'university'];
    List<String> church = [
      'church',
    ];
    List<String> mosque = ['mosque'];
    List<String> worship = ['church', 'place_of_worship', 'mosque'];
    List<String> airport = ['airport'];

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
    } else if (type.any((element) => airport.contains(element))) {
      return Icons.airplanemode_active_outlined;
    }
    return Icons.place_outlined;
  }
}

enum InputFocus { pickup, destination }
