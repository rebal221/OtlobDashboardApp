import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../my_library.dart';

class ShowcaseCard extends StatelessWidget {
  final Widget child;
  final double width;
  final String? label;
  final String? caption;

  const ShowcaseCard({
    Key? key,
    required this.child,
    this.width = 200,
    this.label,
    this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (label != null)
          Container(
            width: width,
            margin: const EdgeInsets.only(bottom: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label!,
                style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3A3A3C),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        Card(
          margin: const EdgeInsets.fromLTRB(12, 4, 12, 24),
          elevation: kIsWeb ? 0 : 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: Colors.transparent,
          child: SizedBox(
            width: width,
            height: width,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                child,
                if (caption != null)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(12)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          width: width,
                          height: 30,
                          color: Colors.white30,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              caption!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8E8E93),
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
