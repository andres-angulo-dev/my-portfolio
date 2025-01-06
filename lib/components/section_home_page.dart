import 'package:flutter/material.dart';
import '../utils/global_colors.dart';

class SectionHomePage extends StatelessWidget {
  final GlobalKey sectionKey;
  final String title;
  final Widget child;

  const SectionHomePage({ super.key, required this.sectionKey, required this.title, required this.child });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center, // Align the main content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
        children: [
          Padding(
            key: sectionKey, // Key for this section to identify it uniquely.
            padding: screenWidth < 768 ? EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0) : EdgeInsets.fromLTRB(35.0, 50.0, 10.0, 5.0), // Padding around the section.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, 
                    color: GlobalColors.titleColor, // title color.
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5.0), // Margin at the bottom of the line.
                  height: 1.0,
                  width: 340.0,
                  color: GlobalColors.titleColor, // Line color.
                )
              ],
            ),
          ),
          child // The main content of the section.
        ],
      )
    );
  }
}
