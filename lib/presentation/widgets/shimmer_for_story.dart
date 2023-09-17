import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForStory extends StatelessWidget {
  const ShimmerForStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
      padding:const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: size.height*0.2,
              width: size.width*0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[100]!,
              ),
            ));
      },
    );
  }
}
