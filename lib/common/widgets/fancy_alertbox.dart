import 'package:flutter/material.dart';

class FancyAlertDialog extends StatelessWidget {
  final String message;
  final onpress;

  const FancyAlertDialog({super.key, required this.message, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Survey Topic:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onpress,
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFB0E0E6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Color(0xFFB0E0E6),
            radius: 30,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}

// Example usage:
void showFancyAlertDialog(BuildContext context, onpress) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FancyAlertDialog(
        onpress: onpress,
        message: "Political environment in Pakistan",
      );
    },
  );
}
