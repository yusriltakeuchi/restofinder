
import 'package:flutter/material.dart';
import 'package:resto/core/config/api.dart';
import 'package:resto/core/models/review_model.dart';
import 'package:resto/core/services/base/base_services.dart';

class ReviewServices extends BaseServices {

  Future<List<ReviewModel>> getAll(String restaurantID, BuildContext context) async {
    var resp = await request(Api.instance.getReview
      .replaceAll("%res_id%", restaurantID), RequestType.GET, context, 
      useToken: true);

    var reviewList = new List<ReviewModel>();

    //* Check if response contains restaurant list
    if (resp.containsKey("user_reviews")) {
      resp["user_reviews"].forEach((val) {
        reviewList.add(ReviewModel.fromJson(val["review"]));
      }); 
    }

    return reviewList;
  }

}