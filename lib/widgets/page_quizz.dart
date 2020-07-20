import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quizz/models/question.dart';
import 'custom_text.dart';

class PageQuizz extends StatefulWidget {
  @override
  _PageQuizzState createState() => new _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz> {

  Question question;

  List<Question> questions = [
    new Question(
        'La devise de la Belgique est l\'union fait la force', true, '',
        'belgique.JPG'),
    new Question(
        'La lune va finir par tomber sur terre à cause de la gravité', false,
        'Au contraire la lune s\'éloigne', 'lune.jpg'),
    new Question('La Russie est plus grande en superficie que Pluton', true, '',
        'russie.jpg'),
    new Question('Nyctalope est une race naine d\'antilope', false,
        'C’est une aptitude à voir dans le noir', 'nyctalope.jpg'),
    new Question(
        'Le Commodore 64 est l\’oridnateur de bureau le plus vendu', true, '',
        'commodore.jpg'),
    new Question('Le nom du drapeau des pirates es black skull', false,
        'Il est appelé Jolly Roger', 'pirate.png'),
    new Question('Haddock est le nom du chien Tintin', false, 'C\'est Milou',
        'tintin.jpg'),
    new Question('La barbe des pharaons était fausse', true,
        'A l\'époque déjà ils utilisaient des postiches', 'pharaon.jpg'),
    new Question(
        'Au Québec tire toi une bûche veut dire viens viens t\'asseoir', true,
        'La bûche, fameuse chaise de bucheron', 'buche.jpg'),
    new Question('Le module lunaire Eagle de possédait de 4Ko de Ram', true,
        'Dire que je me plains avec mes 8GO de ram sur mon mac', 'eagle.jpg'),
  ];

  int i = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    this.question = questions[i];
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery
        .of(context)
        .size
        .width * 0.75;
    return new Scaffold(
      appBar: new AppBar(title: new CustomText("Quizz")
      ),
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new CustomText(
                  "Question number ${i + 1}", color: Colors.grey[900]),
              new CustomText("Score: $score / $i", color: Colors.grey[900],),
              new Card(
                elevation: 10.0,
                child: new Container(
                  height: size,
                  width: size,
                  child: new Image.asset(
                      "assets/${question.imagePath}", fit: BoxFit.cover),
                ),
              ),
              new CustomText(
                question.question, color: Colors.grey[900], factor: 1.3,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buttonBool(true),
                  buttonBool(false)
                ],
              )
            ],
          )
      ),
    );
  }

  RaisedButton buttonBool(bool b) {
    return new RaisedButton(onPressed: () => dialog(b),
        color: Colors.blue,
        elevation: 10.0,
        child: new CustomText((b) ? "True" : "False"));
  }

  Future<Null> dialog(bool b) async {
    bool rightAnswer = (b == question.response);
    String vrai = "assets/vrai.jpg";
    String faux = "assets/faux.jpg";
    if (rightAnswer) {
      score++;
    }

    return showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new CustomText((rightAnswer) ? "Good answer" : "Wrong...",
              color: (rightAnswer) ? Colors.green : Colors.red,),
            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              new Image.asset(
                ((rightAnswer) ? vrai : faux), fit: BoxFit.cover,),
              new Container(height: 25.0,),
              new CustomText(question.explication, color: Colors.grey[900],),
              new Container(height: 25.0,),
              new RaisedButton(onPressed: () {
                Navigator.pop(context);
                nextQuestion();
              }, child: new CustomText("Continue"), color: Colors.blue,)
            ],

          );
        });
  }


  Future<Null> alert() async {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
            title: new CustomText("it's finish", color: Colors.blue,),
            contentPadding: EdgeInsets.all(10.0),
            content: new CustomText(
              "votre score : $score / $i", color: Colors.grey[900],),
            actions: <Widget>[
              new FlatButton(onPressed: () {
                Navigator.pop(buildContext);
                Navigator.pop(context);
              }, child: new CustomText("Ok", factor: 1.25, color: Colors.blue,))
            ],
          );
        });
  }

  void nextQuestion() {
    if (i < questions.length - 1){
      i++;
      setState(() {
        question = questions[i];
      });
    }
    else {
      alert();
    }

  }


}
