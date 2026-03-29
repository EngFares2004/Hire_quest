import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../configuration/theme/theme.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final String? svgPath;
  final bool isSelected;
  final bool isEnvironment;
  final VoidCallback onTap;

  const SelectableCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.svgPath,
    this.isEnvironment =false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ?
              AppTheme.primary :AppTheme.borderColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (svgPath != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: isEnvironment
                        ? SvgPicture.asset(
                      svgPath!,
                      height: 32,
                      width: 32,
                      color: isSelected ? AppTheme.white : AppTheme.primary,
                    )
                        : Image.asset(
                      svgPath!,
                      height: 32,
                      width: 32,
                      fit: BoxFit.contain,
                    ),
                  ),


                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? AppTheme.white : AppTheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),

          /// -------- CHECK MARK WHEN SELECTED --------
          if (isSelected)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color:AppTheme.white ,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.check, size: 18, color:AppTheme.primary ,),
              ),
            ),
        ],
      ),
    );
  }
}
