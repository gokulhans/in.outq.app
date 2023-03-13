import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderLong extends StatelessWidget {
  const PlaceholderLong({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
        ],
      ),
    ));
  }
}

class PlaceholderBig extends StatelessWidget {
  const PlaceholderBig({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12)),
          ),
        ],
      ),
    ));
  }
}