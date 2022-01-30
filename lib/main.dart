import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Navigation lesson',
      home: Scaffold(
        appBar: AppBar(
          title: Text('2048'),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.list)),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        ),
        body: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _MainGameScreen createState() {
    return _MainGameScreen();
  }
}

class _MainGameScreen extends State<HomePage> {
  int _value = 0;
  int _currentScore = 0;
  var _valuesMap = {
    11: 2,
    12: 2,
    13: 0,
    14: 0,
    21: 0,
    22: 0,
    23: 0,
    24: 0,
    31: 0,
    32: 0,
    33: 0,
    34: 0,
    41: 0,
    42: 0,
    43: 0,
    44: 0,
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Score: ${_currentScore}',
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueBox(_valuesMap[11]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[12]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[13]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[14]!.toInt())._getBoxWidget(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueBox(_valuesMap[21]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[22]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[23]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[24]!.toInt())._getBoxWidget(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueBox(_valuesMap[31]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[32]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[33]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[34]!.toInt())._getBoxWidget(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueBox(_valuesMap[41]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[42]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[43]!.toInt())._getBoxWidget(),
                    ValueBox(_valuesMap[44]!.toInt())._getBoxWidget(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          _getLeftMove();
                        },
                        icon: Icon(Icons.arrow_left)),
                    Column(children: [
                      IconButton(
                          onPressed: () {
                            _getUpMove();
                          },
                          icon: Icon(Icons.arrow_upward)),
                      IconButton(
                          onPressed: () {
                            _getDownMove();
                          },
                          icon: Icon(Icons.arrow_downward))
                    ]),
                    IconButton(
                        onPressed: () {
                          _getRightMove();
                        },
                        icon: Icon(Icons.arrow_right)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getRandomBox() {
    var _zeroKeysList = new Set();
    for (int i = 1; i <= 4; i++) {
      for (int j = 1; j <= 4; j++) {
        if (_valuesMap[i * 10 + j] == 0) {
          _zeroKeysList.add(i * 10 + j);
        }
      }
    }
    if (_zeroKeysList.length > 0) {
      final _random = new Random();
      var element =
          _zeroKeysList.elementAt(_random.nextInt(_zeroKeysList.length));
      _valuesMap[element] = 2;
    }
  }

  _getLeftMove() {
    setState(() {
      bool isChanged = false;
      for (int k = 1; k < 5; k++) {
        var currentRow = [
          _valuesMap[k * 10 + 1],
          _valuesMap[k * 10 + 2],
          _valuesMap[k * 10 + 3],
          _valuesMap[k * 10 + 4]
        ];
        for (int j = 0; j < 4; j++) {
          for (int i = 3; i > 0; i--) {
            if (currentRow[i] != 0 && currentRow[i - 1] == 0) {
              currentRow[i - 1] = currentRow[i];
              currentRow[i] = 0;
              isChanged = true;
            }
          }
        }

        for (int i = 0; i < currentRow.length - 1; i++) {
          if (currentRow[i] == currentRow[i + 1]) {
            currentRow[i] = currentRow[i + 1]!.toInt() + currentRow[i]!.toInt();
            currentRow[i + 1] = 0;
            isChanged = true;
          }
        }

        for (int j = 0; j < 4; j++) {
          for (int i = 3; i > 0; i--) {
            if (currentRow[i] != 0 && currentRow[i - 1] == 0) {
              currentRow[i - 1] = currentRow[i];
              currentRow[i] = 0;
              isChanged = true;
            }
          }
        }
        _valuesMap[k * 10 + 4] = currentRow[3]!.toInt();
        _valuesMap[k * 10 + 3] = currentRow[2]!.toInt();
        _valuesMap[k * 10 + 2] = currentRow[1]!.toInt();
        _valuesMap[k * 10 + 1] = currentRow[0]!.toInt();
      }
      if (isChanged) {
        _getRandomBox();
      }
    });
  }

  _getUpMove() {
    setState(() {
      bool isChanged = false;
      for (int k = 1; k < 5; k++) {
        var currentColumn = [
          _valuesMap[10 + k],
          _valuesMap[20 + k],
          _valuesMap[30 + k],
          _valuesMap[40 + k]
        ];
        for (int j = 0; j < 4; j++) {
          for (int i = 3; i > 0; i--) {
            if (currentColumn[i] != 0 && currentColumn[i - 1] == 0) {
              currentColumn[i - 1] = currentColumn[i];
              currentColumn[i] = 0;
              isChanged = true;
            }
          }
        }

        for (int i = 0; i < currentColumn.length - 1; i++) {
          if (currentColumn[i] == currentColumn[i + 1]) {
            currentColumn[i] =
                currentColumn[i + 1]!.toInt() + currentColumn[i]!.toInt();
            currentColumn[i + 1] = 0;
            isChanged = true;
          }
        }

        for (int j = 0; j < 4; j++) {
          for (int i = 3; i > 0; i--) {
            if (currentColumn[i] != 0 && currentColumn[i - 1] == 0) {
              currentColumn[i - 1] = currentColumn[i];
              currentColumn[i] = 0;
              isChanged = true;
            }
          }
        }
        _valuesMap[10 + k] = currentColumn[0]!.toInt();
        _valuesMap[20 + k] = currentColumn[1]!.toInt();
        _valuesMap[30 + k] = currentColumn[2]!.toInt();
        _valuesMap[40 + k] = currentColumn[3]!.toInt();
      }
      if (isChanged) {
        _getRandomBox();
      }
    });
  }

  _getDownMove() {
    setState(() {
      bool isChanged = false;
      for (int k = 1; k < 5; k++) {
        var currentColumn = [
          _valuesMap[10 + k],
          _valuesMap[20 + k],
          _valuesMap[30 + k],
          _valuesMap[40 + k]
        ];
        for (int j = 0; j < 4; j++) {
          for (int i = 0; i < currentColumn.length - 1; i++) {
            if (currentColumn[i] != 0 && currentColumn[i + 1] == 0) {
              currentColumn[i + 1] = currentColumn[i];
              currentColumn[i] = 0;
              isChanged = true;
            }
          }
        }

        for (int i = 0; i < currentColumn.length - 1; i++) {
          if (currentColumn[i] == currentColumn[i + 1]) {
            currentColumn[i] =
                currentColumn[i + 1]!.toInt() + currentColumn[i]!.toInt();
            currentColumn[i + 1] = 0;
            isChanged = true;
          }
        }

        for (int j = 0; j < 4; j++) {
          for (int i = 0; i < currentColumn.length - 1; i++) {
            if (currentColumn[i] != 0 && currentColumn[i + 1] == 0) {
              currentColumn[i + 1] = currentColumn[i];
              currentColumn[i] = 0;
              isChanged = true;
            }
          }
        }
        _valuesMap[10 + k] = currentColumn[0]!.toInt();
        _valuesMap[20 + k] = currentColumn[1]!.toInt();
        _valuesMap[30 + k] = currentColumn[2]!.toInt();
        _valuesMap[40 + k] = currentColumn[3]!.toInt();
      }
      if (isChanged) {
        _getRandomBox();
      }
    });
  }

  _getRightMove() {
    setState(() {
      bool isChanged = false;
      for (int k = 1; k < 5; k++) {
        var currentRow = [
          _valuesMap[k * 10 + 1],
          _valuesMap[k * 10 + 2],
          _valuesMap[k * 10 + 3],
          _valuesMap[k * 10 + 4]
        ];
        for (int j = 0; j < currentRow.length - 1; j++) {
          for (int i = 0; i < currentRow.length - 1; i++) {
            if (currentRow[i] != 0 && currentRow[i + 1] == 0) {
              currentRow[i + 1] = currentRow[i];
              currentRow[i] = 0;
              isChanged = true;
            }
          }
        }

        for (int i = 0; i < currentRow.length - 1; i++) {
          if (currentRow[i] == currentRow[i + 1]) {
            currentRow[i] = currentRow[i + 1]!.toInt() + currentRow[i]!.toInt();
            currentRow[i + 1] = 0;
            isChanged = true;
          }
        }

        for (int j = 0; j < currentRow.length - 1; j++) {
          for (int i = 0; i < currentRow.length - 1; i++) {
            if (currentRow[i] != 0 && currentRow[i + 1] == 0) {
              currentRow[i + 1] = currentRow[i];
              currentRow[i] = 0;
              isChanged = true;
            }
          }
        }
        _valuesMap[k * 10 + 4] = currentRow[3]!.toInt();
        _valuesMap[k * 10 + 3] = currentRow[2]!.toInt();
        _valuesMap[k * 10 + 2] = currentRow[1]!.toInt();
        _valuesMap[k * 10 + 1] = currentRow[0]!.toInt();
      }
      if (isChanged) {
        _getRandomBox();
      }
    });
  }
}

class ValueBox {
  int _valueOfBox;

  ValueBox(this._valueOfBox);

  Container _getBoxWidget() {
    return Container(
      margin: EdgeInsets.all(3),
      alignment: Alignment.center,
      width: 80,
      height: 80,
      child: Text(
        '${_valueOfBox == 0 ? '' : _valueOfBox}',
        style: TextStyle(
            fontSize: _getFountSize(),
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: _getColorTOValue(), width: 2),
        borderRadius: BorderRadius.circular(10),
        color: _getColorTOValue(),
      ),
    );
  }

  double _getFountSize() {
    double fontSize = 20;
    switch (_valueOfBox.toString().length) {
      case 1:
        fontSize = 36;
        break;
      case 2:
        fontSize = 33;
        break;
      case 3:
        fontSize = 30;
        break;
      case 4:
        fontSize = 27;
        break;
      case 5:
        fontSize = 24;
        break;
      case 6:
        fontSize = 21;
        break;
    }
    return fontSize;
  }

  Color _getColorTOValue() {
    Color resultColor = Colors.white;
    switch (this._valueOfBox) {
      case 2:
        resultColor = Colors.yellow;
        break;
      case 4:
        resultColor = Colors.green.shade400;
        break;
      case 8:
        resultColor = Colors.green;
        break;
      case 16:
        resultColor = Colors.blue.shade300;
        break;
      case 32:
        resultColor = Colors.blue.shade400;
        break;
      case 64:
        resultColor = Colors.blue;
        break;
      case 128:
        resultColor = Colors.blue.shade900;
        break;
      case 256:
        resultColor = Colors.purple.shade300;
        break;
      case 512:
        resultColor = Colors.purple.shade400;
        break;
      case 1024:
        resultColor = Colors.purple;
        break;
      case 2048:
        resultColor = Colors.purple.shade900;
        break;
      case 4096:
        resultColor = Colors.red.shade300;
        break;
      case 8192:
        resultColor = Colors.red.shade400;
        break;
      case 16384:
        resultColor = Colors.red;
        break;
      case 32768:
        resultColor = Colors.red.shade900;
        break;
      case 65536:
        resultColor = Colors.orange;
        break;
      case 131072:
        resultColor = Colors.deepOrange;
        break;
    }

    return resultColor;
  }
}
