import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Made abstract to prevent creating an instance
abstract class ResponsivePage extends Widget {
  const ResponsivePage({Key? key}) : super(key: key);

//determines whether to build a mobile or desktop page
  static Widget buildResponsivePage(Widget mobilePage, Widget desktopPage) {
    return LayoutBuilder(builder: (context, constraints) {
      // ? Maybe Finetune Responsivness Later
      var aspectRatio = (MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height));
      if ((constraints.maxWidth > 400) && (aspectRatio >= 0.6)) {
        return desktopPage;
      } else {
        return mobilePage;
      }
    });
  }

  //decides whether to build an optional appbar for iOS
  static PreferredSizeWidget? optionalAppBar() {
    if (Platform.isIOS) {
      return AppBar();
    }
    return null;
  }
}
