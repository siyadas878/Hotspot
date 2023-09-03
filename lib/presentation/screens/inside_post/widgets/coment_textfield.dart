import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../applications/provider/post_provider/coment_provider.dart';
import '../../../../applications/provider/theme_provider/theme_provider.dart';

class ComentTextField extends StatelessWidget {
  const ComentTextField({
    super.key,
    required this.uniqueIdOfPost,
    required this.userId,
  });

  final String uniqueIdOfPost;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Provider.of<LikeComentProvider>(context)
          .commentCntrl,
      maxLines: 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(30)),
        ),
        fillColor: Colors.white,
        hintText: 'Write your comment...',
        hintStyle: TextStyle(
          color:context.read<ThemeProvider>().isDarkMode?Colors.white:Colors.black,
        ),
        suffixIcon: InkWell(
          onTap: () {
            String thisUserId =
                FirebaseAuth.instance.currentUser!.uid;
            Provider.of<LikeComentProvider>(context,
                    listen: false)
                .postComment(
              uniqueIdOfPost,
              userId,
              thisUserId,
            );
          },
          child: const Icon(FontAwesomeIcons.paperPlane),
        ),
      ),
    );
  }
}
