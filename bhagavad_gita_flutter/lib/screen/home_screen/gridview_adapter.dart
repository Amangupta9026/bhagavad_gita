import '../../utils/file_collection.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'E-Books', icon: Icons.copy),
  Choice(title: 'Audio', icon: Icons.music_note),
  Choice(title: 'Video', icon: Icons.video_call),
  Choice(title: 'Aarti', icon: Icons.music_note),
  Choice(title: 'Divine Quotes', icon: Icons.note),
  Choice(title: 'Articles', icon: Icons.article),
  Choice(title: 'Wallpaper', icon: Icons.wallpaper),
  Choice(title: 'My Faviorite', icon: Icons.favorite),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, this.choice}) : super(key: key);
  final Choice? choice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(choice?.icon, size: 40.0, color: primaryColor)),
                Text(choice?.title ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ]),
        ),
      ),
    );
  }
}
