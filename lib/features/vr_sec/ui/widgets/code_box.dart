import 'package:flutter/material.dart';

class CodeBox extends StatelessWidget {
  final String value;

  const CodeBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 7,
      height: MediaQuery.of(context).size.width / 7,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:          Theme.of(context).colorScheme.surface.withOpacity(0.5),

        borderRadius: BorderRadius.circular(12),
        border: Border.all(

          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}