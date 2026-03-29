import 'package:flutter/material.dart';
import 'stat_card.dart';

class StatsGrid extends StatelessWidget {
  final List<StatCard> items;

  const StatsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
       mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: items,
    );
  }
}
