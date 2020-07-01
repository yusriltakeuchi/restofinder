import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resto/core/viewmodels/collection_provider.dart';
import 'package:resto/core/viewmodels/location_provider.dart';
import 'package:resto/core/viewmodels/restaurant_provider.dart';
import 'package:resto/ui/constant/constant.dart';
import 'package:resto/ui/screens/widgets/collection_item.dart';
import 'package:resto/ui/screens/widgets/restaurant_item.dart';
import 'package:resto/ui/screens/widgets/search_item.dart';

class HomeScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        title: _appBar(),
      ),
      body: HomeBody(),
    );
  }


  Widget _appBar() {
    return Builder(
      builder: (context) {

        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            return SearchItem(
              controller: searchController,
              onClick: () => restaurantProv.goToSearchRestaurant(context),
              readOnly: true,
            );
          },
        );
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _locationWidget(),
            SizedBox(height: 10),
            _collectionWidget(),
            SizedBox(height: 10),
            _collectionList(),
            SizedBox(height: 10),
            _restoranList(),
          ],
        ),
      ),
    );
  }

  Widget _locationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: primaryColor, size: 25),
            SizedBox(width: 5),
            Consumer<LocationProvider>(
              builder: (context, locationProv, _) {

                //* If location address stil null
                if (locationProv.address == null) {
                  return CircularProgressIndicator();
                }

                return Expanded(
                  child: Text(
                    locationProv.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54
                    ),
                  ),
                );
              },
            )
            
          ],
        ),
        Divider(color: Colors.black12),
      ],
    );
  }

  Widget _collectionList() {
    return Builder(
      builder: (context) {
        return Consumer2<CollectionProvider, LocationProvider>(
          builder: (context, collectionProv, locationProv, _) {

            //* Make sure the location is not null
            //* because we want to find restaurant by location
            if (locationProv.address == null) {
              locationProv.loadLocation();
              return CircularProgressIndicator();
            }

            //* If collection data null then fetch
            if (collectionProv.collectionList == null) {
              collectionProv.getAll(context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (collectionProv.collectionList.length == 0) {
              return Center(
                child: Text(
                  "Koleksi tidak ditemukan"
                ),
              );
            }
            
            return Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: collectionProv.collectionList.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  var collection = collectionProv.collectionList[index];
                  return CollectionItem(
                    collection: collection,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _collectionWidget() {
    return Text(
      "Koleksi",
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }

  Widget _restoranList() {
    return Builder(
      builder: (context) {
        return Consumer2<RestaurantProvider, LocationProvider>(
          builder: (context, restaurantProv, locationProv, _) {

            //* Make sure the location is not null
            //* because we want to find restaurant by location
            if (locationProv.address == null) {
              locationProv.loadLocation();
              return CircularProgressIndicator();
            }

            //* If collection data null then fetch
            if (restaurantProv.restaurantList == null) {
              restaurantProv.getAll(context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (restaurantProv.restaurantList.length == 0) {
              return Center(
                child: Text(
                  "Restoran tidak ditemukan"
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: restaurantProv.restaurantList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var restaurant = restaurantProv.restaurantList[index];
                return RestaurantItem(
                  restaurant: restaurant
                );
              },
            );
          },
        );
      },
    );
  }
}