part of '../settings_page.dart';

/// [InfoView] is where information present
///
/// loaded from json file located in "assets/lang/"
class InfoView extends StatefulWidget {
  const InfoView({super.key});

  @override
  InfoViewState createState() => InfoViewState();
}

class InfoViewState extends State<InfoView> {
  Map<String, List<dynamic>>? data;

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  // read json file here
  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString('assets/lang/appInfo.json');
    final Map<String, List<dynamic>> jsonData = Map<String, List<dynamic>>.from(
      jsonDecode(jsonString),
    );

    // update state is json file is read
    setState(() {
      data = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Info Page')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Info')),
      body: ListView(
        children:
            data!.entries.map((entry) {
              final title = entry.key;
              final contentLines = entry.value;

              return Column(
                children: [
                  // title
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // content
                  for (var line in contentLines)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        line,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              line.isEmpty
                                  ? Theme.of(context).hintColor
                                  : Colors.black,
                        ),
                      ),
                    ),
                  Divider(),
                ],
              );
            }).toList(),
      ),
    );
  }
}
