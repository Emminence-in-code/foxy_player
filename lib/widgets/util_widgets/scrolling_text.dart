import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  final String text;

  const ScrollingText({super.key, required this.text});

  @override
  _ScrollingTextState createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late double _textWidth;
  late double _containerWidth;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _afterLayout(_) {
    final textKey = GlobalKey();
    final textWidget = Text(
      widget.text,
      key: textKey,
    );
    final textRenderBox =
        textKey.currentContext?.findRenderObject() as RenderBox?;
    _textWidth = textRenderBox?.size.width ?? 0;
    _containerWidth = context.size?.width ?? 0;

    _scrollText();
  }

  void _scrollText() async {
    while (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 10),
        curve: Curves.linear,
      );
      await _scrollController.animateTo(
        0.0,
        duration: const Duration(seconds: 10),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: [
          Center(
            child: Text(widget.text),
          ),
        ],
      ),
    );
  }
}
