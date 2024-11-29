import 'package:flutter/material.dart';
import 'package:triviaa/pages/game_page.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  
  double? _deviceHeight,_deviceWidth;
  double _currentDifficultyLevel = 0;
  final List<String> _difficultyTexts = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleDisplay(),
                _difficultySlider(),
                _startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleDisplay() {
    return Column(
      children: [
        const Text(
          "Triviaa",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficultyTexts[_currentDifficultyLevel.toInt()],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  Widget _difficultySlider() {
    return Slider(
      label: "Difficulty",
      thumbColor: Colors.blue,
      activeColor: const Color.fromARGB(255, 73, 164, 206),
      min: 0,
      max: 2,
      divisions: 2,
      value: _currentDifficultyLevel, 
      onChanged: (_value) {
        setState(() {
          _currentDifficultyLevel = _value;
        });
      },
    );
  }

  Widget _startButton() {
    return MaterialButton(
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
          return GamePage(difficultyLevel: _difficultyTexts[_currentDifficultyLevel.toInt()].toLowerCase(),);
        }));
      },
      child: const Text(
        "Start Game",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}