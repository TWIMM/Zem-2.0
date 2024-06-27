import 'package:flutter/material.dart';
import 'package:agri_market/Auth/OtpPage.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomAlert {
  final String text;
  final IconData? icon;
  final BuildContext context;

  const CustomAlert({
    required this.text,
    this.icon,
    required this.context,
  });
  static showalert(context, text, icon) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      CustomIcons.cancel_outlined,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(
                icon,
                size: 48.0,
                color: Colors.red,
              ),
              SizedBox(height: 16.0),
              StyledText(
                text: text,
                fontName: "Open Sans",
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

}

class CustomAlertValidate {
  final String text;
  final IconData? icon;
  final BuildContext context;
  final String instruction;
  final VoidCallback navigateToOtpPage;

  const CustomAlertValidate({
    required this.text,
    this.icon,
    required this.instruction,
    required this.context,
    required this.navigateToOtpPage,
  });
  static showalertvalidate(
      context, text, icon, instruction, navigateToOtpPage) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      CustomIcons.cancel_outlined,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(
                icon,
                size: 48.0,
                color: Colors.red,
              ),
              SizedBox(height: 16.0),
              StyledText(
                text: text,
                fontName: "Open Sans",
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  navigateToOtpPage(); // Call the provided navigation logic
                },
                child: StyledText(
                  text: instruction,
                  fontName: "Open Sans",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 227, 172, 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UsageConditionsDialog extends StatefulWidget {
  final BuildContext context;
  final Future<void> Function() register;

  const UsageConditionsDialog({
    required this.context,
    required this.register,
  });

  @override
  _UsageConditionsDialogState createState() => _UsageConditionsDialogState();
}

class _UsageConditionsDialogState extends State<UsageConditionsDialog> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    const IconData check_circle_rounded =
        IconData(0xf635, fontFamily: 'MaterialIcons');

    Widget customCheckbox() {
      return InkWell(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
          print(isChecked);
        },
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: Color.fromARGB(255, 14, 135, 248),
              width: 2.0,
            ),
            color: isChecked
                ? Color.fromARGB(255, 14, 135, 248)
                : Colors.transparent,
          ),
          child: isChecked
              ? Icon(
                  Icons.check,
                  size: 20.0,
                  color: Colors.white,
                )
              : null,
        ),
      );
    }

    void _openPdfViewer() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 600, // Adjust the height as needed
                  child: SfPdfViewer.network(
                    'https://ottawa-canada.net/dgu.pdf', // URL of the PDF file
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 14, 135, 248)),
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Nous avons besoin de votre accord',
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'En acceptant cet accord, vous créez un compte sur notre application',
            style: TextStyle(
              fontFamily: "Open Sans",
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // navigateToOtpPage(); // Call the provided navigation logic
              },
              child: Text(
                'Lire attentivement',
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 14, 135, 248),
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ]),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              // Open the PDF viewer here
              _openPdfViewer();
            },
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terms and conditions',
                      style: TextStyle(
                        fontFamily: "Open Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Icon(check_circle_rounded,
                        color: Color.fromARGB(255, 4, 209, 11)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy policy',
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '>',
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 300,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customCheckbox(),
                SizedBox(width: 15),
                Text(
                  ' I read the documentation',
                  style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            height: 40,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 14, 135, 248), // Use the provided color code
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                widget.register();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
              ),
              child: StyledText(
                text: "Accept",
                fontName: "Open Sans",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
