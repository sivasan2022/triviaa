import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  final String difficultyLevel;

  List? questions;
  int _currentQuestionCount = 0;
  int _scoreObtained = 0;

  BuildContext context;
  GamePageProvider({required this.context,required this.difficultyLevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficultyLevel,
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect = 
      questions![_currentQuestionCount]["correct_answer"] == answer;
    _currentQuestionCount++;
    if(isCorrect){
      _scoreObtained++;
    }
    showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      }
    );
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if(_currentQuestionCount == _maxQuestions){
      endGame();
    }else{
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.blue,
        title: const Text(
          "End Game!",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        content: Text("Score: $_scoreObtained/10"),
      );
    },);
    await Future.delayed(Duration(seconds: 3),);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}