import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matrix_word_traversal_test/logic.dart';
import 'package:matrix_word_traversal_test/model.dart';
import 'package:matrix_word_traversal_test/screens/instructions.dart';
import 'package:matrix_word_traversal_test/screens/about.dart';
import 'package:matrix_word_traversal_test/screens/text_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _initialCharCode = 65;
  SearchFor? searchFor;
  Size? totalSize;
  List<List<String>>? valuesInGrid;
  String textToBeSearched = '';
  int? m, n;
  bool tp = true;
  AllDirectionalList? toBeColoured;
  bool _checker = true;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // add value of whatever changes happens in
    textController.addListener(() => textToBeSearched = textController.text);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  /// Reseting all the variables/inputs to null/empty
  void _reset() {
    searchFor = null;
    valuesInGrid = null;
    textToBeSearched = '';
    m = null;
    n = null;
    tp = !tp;
    _checker = true;
    toBeColoured = null;
    textController.text = '-';
  }

  /// Main calculations
  AllDirectionalList calculate(
      {required List<List<String>> gridValues, required String pattern}) {
    searchFor = SearchFor(inGrid: gridValues, text: pattern);

    /// searching at each indices to populate finds
    for (int i = 0; i < gridValues.length; i++) {
      for (int j = 0; j < gridValues[0].length; j++) {
        searchFor!.searchAt(i, j);
      }
    }

    /// returning all the directions list with correct values
    return searchFor!.getColoredIndices();
  }

  /// Creates an overlay to pick character from the dialog
  void _charPickerDialog({required int? value, required Function func}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: ConstantValues.backgroundColor,
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32.0,
            scrollController: FixedExtentScrollController(
              initialItem: 0,
            ),
            onSelectedItemChanged: (int selectedItem) => func(selectedItem),
            children: List<Widget>.generate(26, (int index) {
              return Center(
                child: Text(String.fromCharCode(index +
                    _initialCharCode)), // Using utf codes to get an alphabet List
              );
            }),
          ),
        ),
      ),
    );
  }

  /// Creates an overlay to pick number from the dialog
  void _numberPickerDialog({required int? value, required Function func}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: ConstantValues.backgroundColor,
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32.0,
            scrollController: FixedExtentScrollController(
              initialItem: (value == null) ? 0 : (value - 1),
            ),
            onSelectedItemChanged: (int selectedItem) => func(selectedItem),
            children: List<Widget>.generate(999, (int index) {
              return Center(child: Text((index + 1).toString()));
            }),
          ),
        ),
      ),
    );
  }

  /// Bottom dock created for the inputs
  Widget _bottomBar() {
    return Container(
      height: 120.0,
      decoration: const BoxDecoration(
        color: ConstantValues.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ConstantValues.boxShadowColor,
            blurRadius: 15.0,
            offset: Offset(0, 2),
          )
        ],
      ),
      width: totalSize!.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            // m-button
            onTap: () => toBeColoured != null || !_listEmpty(valuesInGrid ?? [])
                ? {}
                : _numberPickerDialog(
                    value: m,
                    func: (int selectedItem) =>
                        setState(() => m = selectedItem + 1)),
            child: _displayInfo('m', m),
          ),
          GestureDetector(
            // n-button
            onTap: () => toBeColoured != null || !_listEmpty(valuesInGrid ?? [])
                ? {}
                : _numberPickerDialog(
                    value: n,
                    func: (int selectedItem) =>
                        setState(() => n = selectedItem + 1)),
            child: _displayInfo('n', n),
          ),
          (m != null && n != null) // text-button
              ? TextComponent(
                  width: totalSize!.width * 2 / 5,
                  controller: textController,
                  writtenText: textToBeSearched,
                  function: (value) => setState(() => textToBeSearched = value),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  /// Displaying Values for m and n
  Widget _displayInfo(String label, dynamic value) {
    return Tooltip(
      message: "Tap to set value for $label",
      child: Container(
        width:
            label == 'text' ? totalSize!.width * 2 / 5 : totalSize!.width / 5,
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
            Text(label),
            Text((value != null && value != '') ? '$value' : '-',
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }

  Widget _mainView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (m != null && n != null && valuesInGrid != null)
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: DataTable(
                      dividerThickness: 0.0,
                      columns: List.generate(
                          n!,
                          (index) =>
                              DataColumn(label: Text((index + 1).toString()))),
                      rows: List.generate(
                        m!,
                        (r) => DataRow(
                          cells: List<DataCell>.generate(
                            n!,
                            (c) => _tile(row: r, column: c),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const InstructionsScreen(),
          const SizedBox(height: 150.0),
        ],
      ),
    );
  }

  DataCell _tile({required int row, required int column}) {
    bool highlight = false;
    if (toBeColoured != null) {
      if (toBeColoured!.allColoredIndicesList != null) {
        if (toBeColoured!.allColoredIndicesList!.isEmpty) {
          highlight = false;
        }
        if (piListContainsPI(
            list: toBeColoured!.allColoredIndicesList!,
            item: PointerInfo(m: row, n: column))) {
          highlight = true;
        }
      } else {
        highlight = false;
      }
    } else {
      highlight = false;
    }

    String content =
        valuesInGrid![row][column] == 'null' ? '-' : valuesInGrid![row][column];
    return DataCell(
      DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          content,
          style: highlight
              ? const TextStyle(
                  color: ConstantValues.highlightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                )
              : Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      onTap: () => _charPickerDialog(
        value: n,
        func: (int selectedItem) => setState(() => valuesInGrid![row][column] =
            String.fromCharCode(selectedItem + _initialCharCode)),
      ),
    );
  }

  bool _listEmpty(List<List<String>> list) {
    bool temp = true;
    for (int z = 0; z < list.length; z++) {
      for (int y = 0; y < list[z].length; y++) {
        if (list[z][y] != 'null' && list[z][y] != '') temp = false;
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    totalSize = MediaQuery.of(context).size;
    if (m != null && n != null && (_checker || _listEmpty(valuesInGrid!))) {
      valuesInGrid = List.generate(m!, (r) => List.generate(n!, (c) => 'null'));
      _checker = false;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstantValues.accentColor,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: ConstantValues.backgroundColor,
              fontSize: 26.0,
            ),
          ),
          actions: List.generate(
            // All action buttons in 1 function
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Tooltip(
                message: index == 0
                    ? 'Problem Statement'
                    : (index == 1 ? 'Submit' : 'Reset'),
                child: GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0: // for Problem Statement Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutScreen()),
                        );
                        break;
                      case 1:
                        if (valuesInGrid != null && textToBeSearched != '') {
                          setState(() => toBeColoured = calculate(
                              gridValues: valuesInGrid!,
                              pattern: textToBeSearched));
                        }
                        if (valuesInGrid == null || _listEmpty(valuesInGrid!)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            padding: EdgeInsets.only(
                                bottom: 20.0,
                                top: 20.0,
                                left: 24.0,
                                right: 24.0),
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            backgroundColor: ConstantValues.accentColor,
                            content: Text(
                                "Please first input all the values as per the instructions!!"),
                          ));
                        }
                        break;
                      case 2:
                        setState(() => _reset());
                        break;
                    }
                  },
                  child: Hero(
                    tag: index == 0
                        ? "ABOUTHERO"
                        : (index == 1 ? 'HERO' : 'hero'),
                    child: CircleAvatar(
                      backgroundColor: ConstantValues.backgroundColor,
                      child: Center(
                        child: Icon(index == 0
                            ? Icons.info_outlined
                            : (index == 1 ? Icons.check : Icons.restore)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: MediaQuery.of(context).padding.bottom + 20.0,
                  ),
                  child: _mainView(),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom),
                  child: _bottomBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
