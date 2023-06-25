// ignore_for_file: depend_on_referenced_packages

import 'package:bhagavad_gita_flutter/screen/post/models/user_model.dart';
import 'package:meta/meta.dart';


class Story {
  final User? user;
  final String? imageUrl;
  final bool? isViewed;

  const Story({
    @required this.user,
    @required this.imageUrl,
    this.isViewed = false,
  });
}
