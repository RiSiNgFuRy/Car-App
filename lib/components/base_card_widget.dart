import 'package:flutter/material.dart';

import '../utils/dimen.dart';

class BaseCardWidget extends StatefulWidget {
  final String heading;
  Widget child;
  Widget? topRightmostArea;
  Widget? footerArea;
  Icon? leadingIcon;
  EdgeInsetsGeometry? padding;

  BaseCardWidget(
      this.heading,{
        super.key,
        required this.child,
        this.leadingIcon,
        this.topRightmostArea,
        this.footerArea,
        this.padding
      });

  @override
  State<BaseCardWidget> createState() => _BaseCardWidgetState();
}

class _BaseCardWidgetState extends State<BaseCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(Dimen.dim0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(widget.leadingIcon != null)
                    SizedBox(
                      height: Dimen.dim24,
                      width: Dimen.dim24,
                      child: widget.leadingIcon,
                    ),
                    Text(
                      widget.heading,
                      style: const TextStyle (
                        fontSize: Dimen.dim24,
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1
                    ),
                  ]
                ),
               if(widget.topRightmostArea != null)
               Padding(
                 padding: const EdgeInsets.all(Dimen.dim5),
                 child: widget.topRightmostArea
               ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimen.dim5),
            child: widget.child
          ),
          if(widget.footerArea != null)
          Center(
            child: widget.footerArea
          )
        ],
      ),
    );
  }
}


