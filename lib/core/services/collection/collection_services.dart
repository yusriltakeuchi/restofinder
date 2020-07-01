

import 'package:flutter/material.dart';
import 'package:resto/core/config/api.dart';
import 'package:resto/core/models/collection_model.dart';
import 'package:resto/core/services/base/base_services.dart';

class CollectionServices extends BaseServices {

  Future<List<CollectionModel>> getAll(String latitude, String longitude, BuildContext context) async {
    var resp = await request(Api.instance.getCollections
      .replaceAll("%latitude%", latitude)
      .replaceAll("%longitude%", longitude), 
      RequestType.GET, context, 
      useToken: true);

    var collectionList = new List<CollectionModel>();

    //* Check if response contains collection list
    if (resp.containsKey("collections")) {
      resp["collections"].forEach((val) {
        collectionList.add(CollectionModel.fromJson(val["collection"]));
      }); 
    }

    return collectionList;
  }

}