import 'package:flutter/material.dart';
import 'package:matrix_word_traversal_test/model.dart';

class TextComponent extends StatelessWidget {
  const TextComponent(
      {super.key,
      required this.width,
      this.writtenText,
      required this.controller,
      required this.function});

  final double width;
  final String? writtenText;
  final TextEditingController controller;
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Tap to set value for 'text'",
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: ConstantValues.backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: ConstantValues.boxShadowColor,
              blurRadius: 10.0,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('text'),
            SizedBox(
              height: 45.0,
              // Text field for giving value
              child: TextField(
                controller: controller,
                onChanged: (value) => function(value),
                textAlign: TextAlign.center,
                autocorrect: false,
                textCapitalization: TextCapitalization.characters,
                style: Theme.of(context).textTheme.headlineMedium,
                onSubmitted: (value) => function(value),
                decoration: const InputDecoration.collapsed(
                  hintText: "-",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
