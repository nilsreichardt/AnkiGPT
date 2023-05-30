import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ImprintPage extends StatelessWidget {
  const ImprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Impressum')),
      body: const SingleChildScrollView(
        child: MaxWidthConstrainedBox(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SelectionArea(
              child: MarkdownBody(
                selectable: true,
                data: '''Information according to § 5 TMG

Nils Reichardt Agency
Grimmstr. 33
40235 Düsseldorf

## Represented by:
Nils Reichardt

## Contact:
Phone: +49 1522 9504121
E-mail: support@ankigpt.wtf

## Sales tax ID:
Sales tax identification number according to §27a Umsatzsteuergesetz: DE353720936

## Disclaimer:

### Liability for contents

The contents of our pages were created with the greatest care. However, we cannot guarantee the correctness, completeness and up-to-dateness of the contents. As a service provider, we are responsible for our own content on these pages in accordance with general legislation pursuant to § 7 Para.1 TMG. However, according to §§ 8 to 10 TMG, we are not obliged as a service provider to monitor transmitted or stored third-party information or to investigate circumstances that indicate illegal activity. Obligations to remove or block the use of information in accordance with general laws remain unaffected by this. However, liability in this respect is only possible from the point in time at which a concrete infringement of the law becomes known. If we become aware of any such infringements, we will remove this content immediately.

### Liability for links

Our website contains links to external third-party websites over whose content we have no influence. Therefore, we cannot assume any liability for these external contents. The respective provider or operator of the pages is always responsible for the content of the linked pages. The linked pages were checked for possible legal violations at the time of linking. Illegal contents were not recognisable at the time of linking. However, permanent monitoring of the content of the linked pages is not reasonable without concrete indications of a legal violation. If we become aware of any infringements of the law, we will remove such links immediately.
                ''',
                softLineBreak: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
