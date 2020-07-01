import 'package:flutter/material.dart';

class Highlight extends StatelessWidget {

  List<String> highlight;
  Highlight({
    @required this.highlight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: highlight.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          var item = highlight[index];
          return _highLightItem(item);
        },
      ),
    );
  }

  Widget _highLightItem(String item) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black12)
        ),
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.black87
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}