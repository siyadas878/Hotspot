import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmerList extends StatelessWidget {
  const PostShimmerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    height: size.height * 0.25,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 25.0,
                    ),
                    title: Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.grey[300],
                    ),
                    subtitle: Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
