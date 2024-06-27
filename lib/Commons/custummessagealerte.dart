import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:agri_market/Commons/messagetemplate.dart';
import 'package:agri_market/Utils/MyIcons.dart';

class messageAlert extends StatefulWidget {
  final int numberofunread;
  final String sender;
  final String imageUrl;
  const messageAlert(
      {super.key,
      required this.numberofunread,
      required this.sender,
      required this.imageUrl});

  @override
  State<messageAlert> createState() => messageAlertState();
}

class messageAlertState extends State<messageAlert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Slidable(
          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            // dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context) {
                  print('DONE');
                },
                backgroundColor: Color.fromARGB(255, 4, 209, 11),
                foregroundColor: Colors.white,
                icon: CustomIcons.cancel_outlined,
              ),
              SlidableAction(
                onPressed: (context) {
                  print('DONE');
                },
                backgroundColor: Color.fromARGB(255, 4, 209, 11),
                foregroundColor: Colors.white,
                icon: CustomIcons.push_pin_sharp,
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                onPressed: (context) {
                  print('DONE');
                },
                backgroundColor: Color.fromARGB(255, 4, 209, 11),
                foregroundColor: Colors.white,
                icon: CustomIcons.bookmarks_outlined,
              ),
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                onPressed: (context) {
                  print('DONE');
                },
                backgroundColor: Color.fromARGB(255, 4, 209, 11),
                foregroundColor: Colors.white,
                icon: CustomIcons.done_all_outlined,
              ),
              SlidableAction(
                onPressed: (context) {
                  print('DONE');
                },
                backgroundColor: Color.fromARGB(255, 4, 209, 11),
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: Center(
            child: CustomMessage(
              numberofunread: widget.numberofunread,
              sender: widget.sender,
              message: 'Dernier message',
              imageUrl: widget.imageUrl,
            ),
          )),
    );
  }
}
