import 'package:flutter/material.dart';
import 'package:matrix_word_traversal_test/model.dart';

/// Static Main Instructions Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final String title = "Problem Statement";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantValues.accentColor,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: ConstantValues.backgroundColor,
              child: Center(child: Icon(Icons.chevron_left)),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: ConstantValues.backgroundColor,
            fontSize: 26.0,
          ),
        ),
      ),
      body: Hero(
        tag: "ABOUTHERO",
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 20.0, top: 20.0, left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Implement an application which works as follows : -',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "1. Splash Screen",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "2. Enter numbers m & n which indirectly indicates m rows and n column of a 2D grid.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "3. The user should enter alphabets such that one alphabet occupies one position in the grid. Here we will need m*n number of alphabets.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "4. Grid creation done",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "5. Display the grid. Now The user can provide a text which needs to be searched in the grid.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "6. If the text is available in the grid, then those alphabets should be highlighted if the text in the grid is readable in left to right direction (east), or top to bottom direction (south) or diagonal (south-east).",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "7. User can change the text provided in step 5 and check for the occurance of the word in the grid.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30.0),
                Text(
                  'NOTE :',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "*. At anytime, the user should be able to reset the setup and the application starts again from step 2.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "*. APK and the Source code should be shared via dropbox, google drive etc... to hr@mobigic.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 150.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
