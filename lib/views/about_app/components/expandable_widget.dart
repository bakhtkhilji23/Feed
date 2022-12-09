import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    Key? key,
    required this.header,
    required this.body,
    required this.isExpanded,
  }) : super(key: key);

  final String header;
  final String body;
  final bool isExpanded;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  final color = const Color(0xFF9d514e);

  bool expanded = false;

  @override
  initState() {
    expanded = widget.isExpanded;
    setState(
      () {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.header,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                      ),
                    ),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 25,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 200,
          ),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: child,
            );
          },
          child: expanded
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.body,
                      style: const TextStyle(
                        height: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
