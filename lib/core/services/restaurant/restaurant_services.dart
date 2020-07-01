
import 'package:flutter/material.dart';
import 'package:resto/core/config/api.dart';
import 'package:resto/core/models/restaurant_model.dart';
import 'package:resto/core/services/base/base_services.dart';

class RestaurantServices extends BaseServices {

  Future<List<RestaurantModel>> getAll(String latitude, String longitude, BuildContext context) async {
    var resp = await request(Api.instance.getRestaurant
      .replaceAll("%latitude%", latitude)
      .replaceAll("%longitude%", longitude), 
      RequestType.GET, context, 
      useToken: true);

    var restaurantList = new List<RestaurantModel>();
    //* Check if response contains restaurant list
    if (resp.containsKey("restaurants")) {
      resp["restaurants"].forEach((val) {
        restaurantList.add(RestaurantModel.fromJson(val["restaurant"]));
      }); 
    }

    return restaurantList;
  }

  Future<List<RestaurantModel>> getAllByKeyword(String keyword, String latitude, String longitude, BuildContext context) async {
    var resp = await request(Api.instance.searchRestaurantByKeyword
      .replaceAll("%latitude%", latitude)
      .replaceAll("%longitude%", longitude)
      .replaceAll("%keyword%", keyword), 
      RequestType.GET, context, 
      useToken: true);

    var restaurantList = new List<RestaurantModel>();
    //* Check if response contains restaurant list
    if (resp.containsKey("restaurants")) {
      resp["restaurants"].forEach((val) {
        restaurantList.add(RestaurantModel.fromJson(val["restaurant"]));
      }); 
    }

    return restaurantList;
  }

  Future<List<RestaurantModel>> getAllByCollection(String collectionID, BuildContext context) async {
    var resp = await request(Api.instance.getRestaurantByCollection
      .replaceAll("%collection_id%", collectionID),
      RequestType.GET, context, 
      useToken: true);

    var restaurantList = new List<RestaurantModel>();
    //* Check if response contains restaurant list
    if (resp.containsKey("restaurants")) {
      resp["restaurants"].forEach((val) {
        restaurantList.add(RestaurantModel.fromJson(val["restaurant"]));
      }); 
    }

    return restaurantList;
  }

}