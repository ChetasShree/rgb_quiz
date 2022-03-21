import 'package:flutter/material.dart';
import 'package:rgb_quiz/answer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    Future.delayed(Duration.zero, () {
      setState(
        () {
          answerWasSelected = true;
          if (answerScore) {
            _totalScore++;
            correctAnswerSelected = true;
          }
          _scoreTracker.add(
            answerScore
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
          );
          if (_questionIndex + 1 == _questions.length) {
            endOfQuiz = true;
          }
        },
      );
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Mentor Quiz App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: answer['answerText'].toString(),
                answerColor: answerWasSelected.toString() == true
                    ? answer['score'].toString() == true
                        ? Colors.green
                        : Colors.red
                    : Colors.transparent,
                answerTap: () {
                  if (answerWasSelected) {
                    return;
                  }
                  _questionAnswered(answer['score'] == true);
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Please select an answer before going to the next question'),
                  ));
                  return;
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question'),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Well done, you got it right!'
                        : 'Wrong :/',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Congratulations! Your final score is: $_totalScore'
                        : 'Your final score is: $_totalScore. Better luck next time!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'R 239 , G 27 , B 136',
    'answers': [
      {'answerText': 'Pink', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
  {
    'question': 'R 27 , G 215 , B 239',
    'answers': [
      {'answerText': 'Light Blue', 'score': true},
      {'answerText': 'Red', 'score': false},
      {'answerText': 'Black', 'score': false},
    ],
  },
  {
    'question': 'R 255 , G 255 , B 0',
    'answers': [
      {'answerText': 'Yellow', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Red', 'score': false},
    ],
  },
  {
    'question': 'R 255 , G 165 , B 0',
    'answers': [
      {'answerText': 'orange', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
  {
    'question': 'R 50 , G 205 , B 50',
    'answers': [
      {'answerText': 'lime green', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
  {
    'question': 'R 0 , G 206 , B 209',
    'answers': [
      {'answerText': 'dark turquoise', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
  {
    'question': 'R 186 , G 85 , B 211',
    'answers': [
      {'answerText': 'Red', 'score': false},
      {'answerText': 'medium orchid', 'score': true},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
  {
    'question': 'R 139 , G 69 , B 19',
    'answers': [
      {'answerText': 'saddle brown', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
  {
    'question': 'R 230 , G 230 , B 250',
    'answers': [
      {'answerText': 'lavender', 'score': true},
      {'answerText': 'Blue', 'score': false},
      {'answerText': 'Yellow', 'score': false},
    ],
  },
];
