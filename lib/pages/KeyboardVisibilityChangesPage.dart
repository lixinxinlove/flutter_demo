import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardVisibilityChangesPage extends StatefulWidget {
  const KeyboardVisibilityChangesPage({super.key});

  @override
  State<KeyboardVisibilityChangesPage> createState() =>
      _KeyboardVisibilityChangesPageState();
}

class _KeyboardVisibilityChangesPageState
    extends State<KeyboardVisibilityChangesPage> {
  TextEditingController textEditingController = TextEditingController();

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {

    super.initState();



    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
                      ),
                      TextField(
                        controller: textEditingController,
                      ),
                    ],
                  )
                ],
              )),
    );
  }
}
