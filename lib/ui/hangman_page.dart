import 'package:flutter/material.dart';
import 'package:hangman/engine/hangman.dart';
import 'package:hangman/ui/hangman_page.dart';


// These are all the images used for this game
const List<String> progressImages = const [
  'images/progress_0.png',
  'images/progress_1.png',
  'images/progress_2.png',
  'images/progress_3.png',
  'images/progress_4.png',
  'images/progress_5.png',
  'images/progress_6.png',
  'images/progress_7.png',
];
// This will be shown, when the player beats the game
const String victoryImage = 'images/victory.png';

// These are all the letters im the alphabet, without any umlaut
const List<String> alphabet = const [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
];

const TextStyle activeWordStyle = TextStyle(
    fontSize: 30.0,
    letterSpacing: 5.0
);

class HangmanPage extends StatefulWidget {
  final HangmanGame _engine;

  HangmanPage(this._engine);

  @override
  State<StatefulWidget> createState() => _HangmanPageState();
}
class _HangmanPageState extends State<HangmanPage> {

  // Defining variables to track UI Elements
  bool _showNewGame;
  String _activeImage;
  String _activeWord;

  @override
  void initState() {
    super.initState();

    widget._engine.onChange.listen(this._updateWordDisplay);
    widget._engine.onWrong.listen(this._updateGallowsImage);
    widget._engine.onWin.listen(this._win);
    widget._engine.onLose.listen(this._gameOver);

    this._newGame();
  }

  void _newGame() {
    widget._engine.newGame();
// When new game is called, these "settings" are set and displayed.
    this.setState(() {
      _activeWord = '';
      _activeImage = progressImages[0];
      _showNewGame = false;
    });
  }
// onChange: This method is called with the new word. It gets re-rendered inside of setState()
  void _updateWordDisplay(String word) {
    this.setState(() {
      _activeWord = word;
    });
  }
// onWrong: Gives the number of incorrect guesses for a word.
  void _updateGallowsImage(int wrongGuessCount) {
    this.setState(() {
      _activeImage = progressImages[wrongGuessCount];
    });
  }
// onWin: The victory image will be set.
  void _win([_]) {
    this.setState(() {
      _activeImage = victoryImage;
      this._gameOver();
    });
  }
// Triggered by onLose and onWin: sets _showNewGame to true.
  void _gameOver([_]) {
    this.setState(() {
      _showNewGame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hangman'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image
            Expanded(
              child: Image.asset(_activeImage),
            ),
            // Word
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(_activeWord, style: activeWordStyle),
              ),
            ),
            // Controls
            Expanded(
              child: Center(
                child: this._renderBottomContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderBottomContent() {
    if(_showNewGame) {
      return Container(
        child: new FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent,
          elevation: 4.0,
          onPressed: this._newGame, icon: new Icon(Icons.videogame_asset), label: new Text("NEUES SPIEL"),
        ),
      );
    } else {
      final Set<String> letterGuessed = widget._engine.lettersGuessed;

      // A Wrap displays its children in multiple horizontal or vertical runs.
      return Wrap(
        spacing: 1.0,
        runSpacing: 1.0,
        alignment: WrapAlignment.center,
        children: alphabet.map((letter) => MaterialButton(
          child: Text(letter),
          padding: EdgeInsets.all(2.0),
          onPressed: letterGuessed.contains(letter) ? null : () {
            widget._engine.guessLetter(letter);
          },
        )).toList(),
      );
    }

  }

}