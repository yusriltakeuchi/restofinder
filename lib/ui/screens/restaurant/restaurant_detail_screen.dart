import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto/core/models/restaurant_model.dart';
import 'package:resto/core/utils/currency_utils.dart';
import 'package:resto/core/viewmodels/restaurant_provider.dart';
import 'package:resto/ui/screens/restaurant/items/highlight.dart';
import 'package:resto/ui/screens/widgets/custom_rating.dart';
import 'package:resto/ui/screens/widgets/review_item.dart';

class RestaurantDetailScreen extends StatelessWidget {
  RestaurantModel restaurant;
  RestaurantDetailScreen({
    @required this.restaurant
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RestaurantDetailBody(
        restaurant: restaurant,
      ),
    );
  }
}

class RestaurantDetailBody extends StatefulWidget {
  RestaurantModel restaurant;
  RestaurantDetailBody({
    @required this.restaurant
  });
  
  @override
  _RestaurantDetailBodyState createState() => _RestaurantDetailBodyState();
}

class _RestaurantDetailBodyState extends State<RestaurantDetailBody> {

  Color iconBackColor = Colors.white;
  Color textColor = Colors.white;
  Color backgroundColor = Colors.transparent;

  ScrollController scrollController;
  _scrollListener() {
    if (scrollController.offset >= 100) {
      setState(() {
        iconBackColor = Colors.black87;
        textColor = Colors.black87;
        backgroundColor = Colors.white;
      });
    } else {
      setState(() {
        iconBackColor = Colors.white;
        textColor = Colors.white;
        backgroundColor = Colors.transparent;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          child: _content()
        ),
        _appBar(),
      ],
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              height: 24,
              color: backgroundColor,
            ),
            Container(
              height: 50,
              color: backgroundColor,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: iconBackColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.restaurant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _content() {
    return Container(
      child: Column(
        children: <Widget>[
          _imageCover(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                CustomRating(
                  rating: widget.restaurant.ratingStar,
                  review: widget.restaurant.review,
                ),
                SizedBox(height: 15),
                _title(),
                SizedBox(height: 5),
                _cuisines(),
                SizedBox(height: 5),
                _address(),
                SizedBox(height: 5),
                _price(),

                Divider(color: Colors.black12),
                Highlight(
                  highlight: widget.restaurant.highlights,
                ),
                Divider(color: Colors.black12),

                SizedBox(height: 10),
                _addressFull(),
                SizedBox(height: 15),
                _openTime(),
                SizedBox(height: 10),
                Divider(color: Colors.black12),
                SizedBox(height: 15),
                _reviews(),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage(widget.restaurant.imgURL),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.restaurant.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }

  Widget _cuisines() {
    return Text(
      widget.restaurant.cuisines,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 12
      ),
    );
  }

  Widget _address() {
    return Text(
      widget.restaurant.address,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 12
      ),
    );
  }

  Widget _price() {
    return Text(
      "${widget.restaurant.currency} ${formatter.format(widget.restaurant.priceForTwo)} / 2 person",
      style: TextStyle(
        color: Colors.green,
        fontSize: 14,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _addressFull() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Alamat Restoran",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5),
        Text(
          widget.restaurant.addressFull,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12
          ),
        ),
      ],
    );
  }

  Widget _openTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Jam Buka",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5),
        Text(
          widget.restaurant.openTime,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12
          ),
        ),
      ],
    );
  }

  Widget _reviews() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Review Terbaru",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            _reviewList()
          ],
        );
      },
    );
  }

  Widget _reviewList() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            
            //* If review is null then fetch
            if (restaurantProv.reviewList == null) {
              restaurantProv.getReviewByResID(widget.restaurant.id.toString(), context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (restaurantProv.reviewList.length == 0) {
              return Center(
                child: Text(
                  "Belum ada review"
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: restaurantProv.reviewList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var review = restaurantProv.reviewList[index];
                return ReviewItem(
                  review: review,
                );
              },
            );
          },
        );
      },
    );
  }
}