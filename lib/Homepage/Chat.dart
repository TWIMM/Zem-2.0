import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Utils/constantes.dart';

class ChatDetailPageWrapper extends StatefulWidget {
  const ChatDetailPageWrapper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatDetailPageWrapperState createState() => _ChatDetailPageWrapperState();
}

class _ChatDetailPageWrapperState extends State<ChatDetailPageWrapper> {
  ChatOptions options = ChatOptions(sender: "User001", receiver: "User002");

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Use a delay to ensure the initialization happens after the build cycle
    Future.delayed(Duration.zero, () {
      final userProvider =
          Provider.of<CurrentIndexProvider>(context, listen: false);
      userProvider.initializeChat(
          "Je suis interessé par votre produit", options, "now");
    });
  }

  void connectToSocket() {
    // Replace 'https://your_socket_server_url' with the URL of your Socket.IO server.
    final socket = io.io(socketBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to the socket server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the socket server');
    });

    socket.on('message_sent', (data) {
      print('Received message: $data');
    });

    // Add more event listeners and functionality as needed.

    // To send a message to the server, use:
    // socket.emit('eventName', 'message data');
  }

  @override
  Widget build(BuildContext context) {
    return ChatDetailPage();
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5F5F8),
      elevation: 0,
      toolbarHeight: 90,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 15),
        onPressed: () {
          // Handle back button press
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black, size: 15),
          onPressed: () {
            // Handle three dots press
            // You can show a menu or perform some action here
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.phone,
            color: Colors.black,
            size: 15,
          ),
          onPressed: () {
            // Handle phone icon press
            // You can initiate a phone call or perform some other action
          },
        ),
      ],
      title: const Row(
        children: [
          CircleAvatar(
            // Add your profile picture logic here
            backgroundImage: AssetImage(
              'assets/icons/pp.png',
            ),
          ),
          SizedBox(width: 10),
          StyledText(
            text: '@user_001',
            fontName: "Open Sans",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatDetailPage extends StatelessWidget {
  ChatOptions options = ChatOptions(sender: "User001", receiver: "User002");

  void sendMessage(String message) {
    final socket = io.io(socketBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.emit('message_sent', {
      'sender': 'hicli0001@gmail.com',
      'receiver': 'hicli0001@gmail.com',
      'message': 'Hello',
    });
  }

  ChatDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Consumer<CurrentIndexProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          appBar: const MyAppBar(),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: userProvider.messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 70),
                  itemBuilder: (context, index) {
                    final message = userProvider.messages[index];

                    return Column(
                      crossAxisAlignment:
                          (message.options.sender as String) == 'user001'
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Align(
                            alignment:
                                (message.options.sender as String) == 'user001'
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (message.options.sender as String) ==
                                        'user001'
                                    ? Colors.grey.shade200
                                    : const Color.fromARGB(255, 4, 209, 11),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    message.messageContent,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 7, 7, 7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color.fromARGB(255, 243, 241, 241),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icons/Plus.png'),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 198, 198, 198),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  hintText: "Ecrire un message ...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                            Image.asset('assets/icons/emoji.png'),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset('assets/icons/Camera.png'),
                    const SizedBox(width: 5),
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        /* border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ), */
                      ),
                      child: FloatingActionButton(
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 12,
                        ),
                        backgroundColor: const Color(0xFFFFB405),
                        elevation: 0,
                        onPressed: () {
                          sendMessage(messageController.text);
                          messageController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
