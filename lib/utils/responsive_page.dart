import 'package:flutter/widgets.dart';

// Made abstract to prevent creating an instance
abstract class ResponsivePage extends Widget {
  const ResponsivePage({Key? key}) : super(key: key);

  static Widget buildResponsivePage(Widget mobilePage, Widget desktopPage) {
    return LayoutBuilder(builder: (context, constraints) {
      // ? Maybe Finetune Responsivness Later
      var aspectRatio = (MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height));
      if ((constraints.maxWidth > 400) && (aspectRatio >= 0.6)) {
        // TODO activate desktop pages by changing line below
        return mobilePage;
      } else {
        return mobilePage;
      }
    });
  }
}
