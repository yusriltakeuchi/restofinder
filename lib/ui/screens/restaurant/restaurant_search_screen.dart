import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resto/core/viewmodels/restaurant_provider.dart';
import 'package:resto/ui/constant/constant.dart';
import 'package:resto/ui/screens/widgets/restaurant_mini_item.dart';
import 'package:resto/ui/screens/widgets/search_item.dart';

class RestaurantSearchScreen extends StatefulWidget {

  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: _appBar(),
      ),
      body: RestaurantSearchBody(),
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {

            return SearchItem(
              controller: searchController,
              autoFocus: true,
              onSubmit: (value) => restaurantProv.getAllByKeyword(value, context),
            );
          },
        );
      },
    );
    
  }
}

class RestaurantSearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _restorantCount(),
            _restoranList(),
          ],
        ),
      ),
    );
  }


  Widget _restorantCount() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {

            if (restaurantProv.restaurantByKeywordList == null) {
              return SizedBox();
            }

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: primaryColor),
                    SizedBox(width: 10),
                    Text(
                      "${restaurantProv.restaurantByKeywordList.length.toString()} restoran ditemukan",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        
                      ),
                    ),
                  ],
                ),

                Divider(color: Colors.black12),
              ],
            );
          },
        );
      },
    );
  }

  Widget _restoranList() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {

            //* If collection data null then fetch
            if (restaurantProv.restaurantByKeywordList == null && restaurantProv.onSearch == false) {
              return Center(
                child: Text(
                  "Mau cari restoran apa?"
                ),
              );
            }

            if (restaurantProv.onSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (restaurantProv.restaurantByKeywordList.length == 0) {
              return Center(
                child: Text(
                  "Restoran tidak ditemukan"
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: restaurantProv.restaurantByKeywordList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var restaurant = restaurantProv.restaurantByKeywordList[index];
                return RestaurantMiniItem(
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