part of '../map.dart';

Widget dialogBox(MapTriedFoundRoute state, BuildContext context) {
  return Positioned(
    left: 0,
    top: 0,
    child: InkWell(
      onTap: () {
        if (state.isFound) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutePage(state)),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
          8.0,
          8.0 + MediaQuery.of(context).padding.top,
          8.0,
          0,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(245),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          (state.isFound)
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Route found\n",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ...formatRoute(state).map(
                    (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  e
                      .map(
                        (text) =>
                    e.indexOf(text) == e.length - 1
                        ? Text(
                      text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : Text("$text "),
                  )
                      .toList(),
                ),
              ),

              const Text(
                "\n Click here for details",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                state.route.toTimeString(state.map),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
              : Center(
            child: Column(
              children: [
                Text(
                  "route not found",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("If you believe this is wrong"),
                Text("settings -> tell us a route"),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}