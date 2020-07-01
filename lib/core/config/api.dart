class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  static const baseURL = "https://developers.zomato.com/api/v2.1";

  //* ---------------
  //* ENDPOINT FIELD
  //* ----------------

  //* Collection Endpoint
  //* Please replace %latitude% and %longitude%
  //* with your location coordinate
  String getCollections = "$baseURL/collections?lat=%latitude%&lon=%longitude%";

  //* Restaurant Endpoint
  //* Please replace %latitude% and %longitude%
  //* with your location coordinate
  //* radius = 20000 = 20km (in meters)
  String getRestaurant = "$baseURL/search?lat=%latitude%&lon=%longitude%&radius=20000";

  //* Restaurant Endpoint
  //* Please replace %latitude% and %longitude%
  //* with your location coordinate
  //* radius = 20000 = 20km (in meters)
  //* and %keyword% with your keyword
  String searchRestaurantByKeyword = "$baseURL/search?q=%keyword%&lat=%latitude%&lon=%longitude%&radius=20000";

  //* Find Restaurant by collection id Endopoint
  //* Please replace %collection_id% 
  //* with your collection
  String getRestaurantByCollection = "$baseURL/search?collection_id=%collection_id%";

  //* Review Endpoint
  //* Please replace %res_id% with your restaurant_id
  String getReview = "$baseURL/reviews?res_id=%res_id%&start=0&count=20";
}
