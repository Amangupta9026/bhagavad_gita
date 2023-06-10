import 'package:bhagavad_gita_flutter/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widget/app_bar_header.dart';

class AdminMoreApps extends StatelessWidget {
  const AdminMoreApps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Admin More Apps',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('App Name',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              hinttext1: 'App Name',
            ),
            const SizedBox(height: 20),
            const Text('App Image',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              hinttext1: 'App Image',
            ),
            const SizedBox(height: 20),
            const Text('App link',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              hinttext1: 'App Link',
            ),

            const SizedBox(height: 50),
            //Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
