import 'package:go_router/go_router.dart';

import '../utils/file_collection.dart';

class AppBarHeader extends StatelessWidget {
  final String? text;

  const AppBarHeader({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        title: Text(
          text ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ));
  }
}
