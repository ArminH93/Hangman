import 'package:flutter/material.dart';

import 'package:hangman/engine/hangman.dart';
import 'package:hangman/ui/hangman_page.dart';

const List<String> wordList = const ["WEIHNACHTEN","RHYTHMUS","METAPHER","KIRSCHKERN","LOKOMOTIV","QUANTITATIV","FAUPAX","PANTOFFELHELD","PLANUNGSSICHERHEIT","YACHT","ZALANDO","ZEITLUPE","SCHADENFREUDE","WELTSCHMERZ","ADRESSE","ANTIPATHIE","ASYMMETRIE","BILLARD","ATTACKE","CHARISMA","DILETTANT","FITNESS","FRONLEICHNAM","ESSENZIELL","INTERESSE","KAROSSERIE","KREISSSAAL","KOMITEE","KUMULIEREN","MASCHINE","MITHILFE","PAPPENSTIEL","PANEEL","REDUNDANT","REPARATUR","RENTIER","REFLEXION","SATELLIT","SAITE","RESSOURCE","QUARZUHR","SISYPHUSARBEIT","SCHMELZEN","SPAGHETTI",];

void main() => runApp(HangmanApp());

class HangmanApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HangmanAppState();
}

class _HangmanAppState extends State<HangmanApp> {
  HangmanGame _engine;

  @override
  void initState() {
    super.initState();

    _engine = HangmanGame(wordList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      debugShowCheckedModeBanner: false,
      home: HangmanPage(_engine),
    );
  }
}