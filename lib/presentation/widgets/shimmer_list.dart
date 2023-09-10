import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
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
        );
      },
    );
  }
}
