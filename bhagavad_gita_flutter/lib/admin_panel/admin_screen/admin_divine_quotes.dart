import 'package:bhagavad_gita_flutter/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widget/app_bar_header.dart';

class AdminQuotes extends StatelessWidget {
  const AdminQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Admin Quotes',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quotes',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              hinttext1: 'Quotes',
            ),
            const SizedBox(height: 20),
            const Text('Background Image',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const TextFormFieldWidget(
              hinttext1: 'Background Image',
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
