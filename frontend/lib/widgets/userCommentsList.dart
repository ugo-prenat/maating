import 'package:flutter/material.dart';
import 'package:maating/models/comment.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/widgets/commentCard.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserCommentsList extends StatefulWidget {
  const UserCommentsList({
    super.key,
    required this.userId,
    required this.panelController,
    required this.controller,
  });

  final String userId;
  final ScrollController controller;
  final PanelController panelController;

  @override
  State<UserCommentsList> createState() => _UserCommentsListState();
}

class _UserCommentsListState extends State<UserCommentsList> {
  final _client = http.Client();
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.0;

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<Comment>>(
          future: RequestManager(_client).getCommentsByUserId(widget.userId),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Comment>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              return Center(
                child: snapshot.data!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Aucun avis trouvé',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 30),
                          dragHandle(),
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              'Liste des avis',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ListViewBuilder(snapshot.data!)
                        ],
                      ),
              );
            } else {
              return const Text('Une erreur est survenue');
            }
          },
        ),
      ),
    );
  }

  Widget dragHandle() => Center(
        child: Container(
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget ListViewBuilder(List<Comment> comments) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CommentCard(
            comment: comments[index],
          ),
          itemCount: comments.length,
        ),
      ],
    );
  }
}
