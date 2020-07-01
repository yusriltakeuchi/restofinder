import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto/core/models/collection_model.dart';
import 'package:resto/core/services/collection/collection_services.dart';
import 'package:resto/core/viewmodels/location_provider.dart';
import 'package:resto/core/viewmodels/restaurant_provider.dart';
import 'package:resto/injector.dart';
import 'package:resto/ui/router/router_generator.dart';

class CollectionProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* Collection list variable
  List<CollectionModel> _collectionList;
  List<CollectionModel> get collectionList => _collectionList;

  //* Dependency Injection
  CollectionServices collectionServices = locator<CollectionServices>();

  //* ----------------------------
  //* Function field
  //* ----------------------------

  /// Function to get all collection in jakarta
  void getAll(BuildContext context) async {
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _collectionList = await collectionServices.getAll(
      locationProv.latitude.toString(), locationProv.longitude.toString(),
      context);
    notifyListeners();
  }

  /// Function to navigate to restaurant list by collection
  void goToRestaurantList(CollectionModel collection, BuildContext context) async {
    await Provider.of<RestaurantProvider>(context, listen: false).clearRestaurantByCollection();
    Navigator.pushNamed(context, RouterGenerator.routeRestaurantByCollection,
      arguments: collection);
  }
}