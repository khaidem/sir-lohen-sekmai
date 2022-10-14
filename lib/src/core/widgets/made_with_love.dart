import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MadeWithLove extends StatelessWidget {
  const MadeWithLove({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _launch("https://www.globizs.com");
      },
      child: const Text(
        "Made with ♥ at Globizs",
        // textAlign: TextAlign.center,
      ),
    );
  }

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      log("Not supported");
    }
  }
}
