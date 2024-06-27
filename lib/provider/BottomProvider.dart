import 'package:flutter/foundation.dart';

class ChatOptions {
  String sender;
  String receiver;

  ChatOptions({
    required this.sender,
    required this.receiver,
  });
}

class ChatMessage {
  String messageContent;
  String date;
  ChatOptions options;

  ChatMessage({
    required this.messageContent,
    required this.date,
    required this.options,
  });
}

class CurrentIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;
  List messages = []; // List to hold messages
  var userAccountDetails = {
    "account_type": "",
    "authToken": "",
    "user_email": "",
    "user_name": "",
    "company_name": "",
    "activity": "",
    "adress": "",
    "_id": "",
    "country": "",
    "codeZip": "",
    "register_number": "",
    "phone_number": "",
    "friend_list": [],
    "profile_info": [],
  };

  var mode = 'From Gallery';

  var displayText = [
    {"id": 1, "text": "Type"},
    {"id": 2, "text": "Catégorie"},
    {"id": 3, "text": "Pays"}
  ];
  void updateCategoryLabel(var id, var value) {
    for (int i = 0; i < displayText.length; i++) {
      if (displayText[i]["id"] == id) {
        displayText[i]["text"] = value;
        notifyListeners();
        break; // Stop the loop once the update is done
      }
    }
  }

  rebuild() {
    notifyListeners();
  }

  getTextById(var id) {
    for (var entry in displayText) {
      if (entry["id"] == id) {
        return entry["text"];
      }
    }
    return ""; // Return an empty string if the id is not found
  }

  updateMode(var mymode) {
    mode = mymode;
    notifyListeners();
  }

  var myselectedCategoryId = 1;
  var countries = [];
  var offerBy = {"appBarTitle": "", "listOfOffers": []};
  var countryList = [];
  var selectedCategoryId = 1;
  var selectedCategory = "";

  void setSelectedCategory(var key, var value) {
    key = value;
    notifyListeners();
  }

  void setSimpleProviderValue(value) {
    myselectedCategoryId = value;
    notifyListeners();
  }

  dynamic getAccountDetail(String key) {
    return userAccountDetails[key];
  }

  void setAccountDetail(String key, dynamic value) {
    userAccountDetails[key] = value;
    notifyListeners();
  }

  void setOfferBY(String key, dynamic value) {
    offerBy[key] = value;
  }

  void setCountry(value) {
    countryList = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void addMessage(String messageContent, ChatOptions options, String date) {
    final newMessage = ChatMessage(
        messageContent: messageContent, options: options, date: date);
    messages.add(newMessage);
    notifyListeners();
  }

  void initializeChat(messageContent, options, date) {
    if (messages.isEmpty) {
      // Only add initial message if the list is empty
      messages.add(ChatMessage(
          messageContent: messageContent, date: date, options: options));
      notifyListeners();
    }
  }
}
