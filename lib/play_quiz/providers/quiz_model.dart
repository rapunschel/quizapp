import 'package:flutter/material.dart';

class QuizModel extends ChangeNotifier {
  Quiz _quiz = initiateQuiz();

  // Index for current question
  int currentQuestionIndex = 0;

  // Counters for answered questions
  int noCorrect = 0;
  int noIncorrect = 0;

  // Flag to check if current question has been answered
  bool isAnswered = false;

  // List of lists to keep track of correct /incorrect answered questions
  int correctQuestionsIndex = 0;
  int incorrectQuestionsIndex = 1;
  List<List<(Question, Answer)>> _doneQuestions = [];
  // Save question
  QuizModel();

  // Set quiz and reset all variables
  void setQuiz(Quiz quiz) {
    _quiz = quiz;
    currentQuestionIndex = 0;
    noCorrect = 0;
    noIncorrect = 0;
    isAnswered = false;
    _doneQuestions = [];
    notifyListeners();
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    noCorrect = 0;
    noIncorrect = 0;
    isAnswered = false;
    _doneQuestions = [];
    notifyListeners();
  }

  void addDoneQuestion(Answer answer) {
    if (!isAnswered) {
      if (_doneQuestions.isEmpty) {
        // Initialize with 2 empty lists
        _doneQuestions = [[], []];
      }
      if (answer.isCorrect) {
        _doneQuestions[correctQuestionsIndex]
            .add((getCurrentQuestion(), answer));
        return;
      }
      _doneQuestions[incorrectQuestionsIndex]
          .add((getCurrentQuestion(), answer));
    }
  }

  List<(Question, Answer)> getCorrectQuestions() {
    return _doneQuestions[correctQuestionsIndex];
  }

  List<(Question, Answer)> getIncorrectQuestions() {
    return _doneQuestions[incorrectQuestionsIndex];
  }

  void updateIsAnswered() {
    // If user tap multiple times on listtile, only notify once
    if (isAnswered) {
      return;
    }
    // Else set to true and notify listeners.
    isAnswered = true;
    notifyListeners();
  }

  // Update counters and store question
  void incrementNoCorrect() {
    if (noCorrect + noIncorrect <= currentQuestionIndex) {
      noCorrect++;
      notifyListeners();
    }
  }

  void incrementNoIncorrect() {
    if (noCorrect + noIncorrect <= currentQuestionIndex) {
      noIncorrect++;
      notifyListeners();
    }
  }

  // Getters
  int getNumberOfQuestions() {
    return _quiz!.questions.length;
  }

  List getCurrentAnswers() {
    return _quiz!.questions[currentQuestionIndex].answers;
  }

  Question getCurrentQuestion() {
    return _quiz!.questions[currentQuestionIndex];
  }

  get title => _quiz!.title;

  void getNextQuestion() {
    // Reset isAnswered
    isAnswered = false;
    // Only increment if we are in range.
    if (currentQuestionIndex < _quiz!.questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }
}

// All below for test run only, delete later
Quiz initiateQuiz() {
  Quiz quiz = Quiz("Capital of countries");

  Question question1 = Question("Capital of Sweden?");
  question1.addAnswer("Malmö", false);
  question1.addAnswer("Gothenburg", false);
  question1.addAnswer("Stockholm", true);

  Question question2 = Question("Capital of England?");
  question2.addAnswer("London", true);
  question2.addAnswer("Berlin", false);
  question2.addAnswer("Brighton", false);
  question2.addAnswer("Edinburgh", false);

  Question question3 = Question("Capital of Japan?");
  question3.addAnswer("Tokyo", true);
  question3.addAnswer("Kyoto", false);
  question3.addAnswer("Osaka", false);
  question3.addAnswer("Fukuoka", false);

  Question question4 = Question("Trick question?");
  question4.addAnswer("yes", false);
  question4.addAnswer("no", true);
  question4.addAnswer("maybe", false);
  question4.addAnswer("nope", true);
  quiz.addQuestion(question1);
  quiz.addQuestion(question2);
  quiz.addQuestion(question3);
  quiz.addQuestion(question4);

  return quiz;
}

// Classes to model a quiz
class Quiz {
  String title;
  List<Question> questions = [];

  Quiz(this.title);

  void addQuestion(Question question) {
    questions.add(question);
  }
}

class Question {
  String title;
  List answers = [];

  Question(this.title);

  void addAnswer(String text, bool isCorrect) {
    answers.add(Answer(text, isCorrect));
  }
}

class Answer {
  String text;
  bool isCorrect;

  Answer(this.text, this.isCorrect);
}
