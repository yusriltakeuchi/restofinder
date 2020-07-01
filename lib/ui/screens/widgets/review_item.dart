import 'package:flutter/material.dart';
import 'package:resto/core/models/review_model.dart';
import 'package:resto/ui/screens/widgets/custom_rating.dart';

class ReviewItem extends StatelessWidget {

  ReviewModel review;
  ReviewItem({
    @required this.review
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    _imageUser(),
                    SizedBox(width: 10),
                    _nameAndTime()
                  ],
                ),
              ),
              CustomRating(
                rating: review.ratingStar,
                useReview: false,
              ),
            ],
          ),
          SizedBox(height: 10),
          _captionField(),

          SizedBox(height: 10),
          Divider(color: Colors.black12),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _imageUser() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(review.user.imgURL)
        )
      ),
    );
  }

  Widget _nameAndTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            review.user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          Text(
            review.time,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13
            ),
          ),
        ],
      ),
    );
  }

  Widget _captionField() {
    return Container(
      child: Text(
        review.text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 13
        ),
      ),
    );
  }

}