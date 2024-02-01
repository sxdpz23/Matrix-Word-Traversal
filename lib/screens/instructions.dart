import 'package:flutter/material.dart';

/// Static Main Instructions Screen
class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0, top: 10.0, left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Please follow the below mentioned instructions : -',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10.0),
          Text(
            "1. For number of Rows : Tap on the bottom-left button labeled with 'm' to select a value from the overlay.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "2. For number of Columns : Tap on the bottom-middle button labeled with 'n' to select a value from the overlay.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "3. For 2D grid content values : Tap on the respective tile of the grid and enter your single letter alphabet.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "4. For text to be searched : Tap on the bottom-right button labeled with 'text' to enter your desired text/pattern to be searched.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "5. Hit the above right CHECK button once you have inputted all the values to get the highlighted readable pattern.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "6. Hit the above right RESET button to reset all the data and start again.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 30.0),
          Text(
            'NOTE :',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10.0),
          Text(
            "*. You can re-edit any value again and hit submit/check button to get updated results.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "*. You can TAP-and-HOLD on most of the buttons to get a helpful tip on the function of the buttons.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
