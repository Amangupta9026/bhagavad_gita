import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:flutter/material.dart';

class EbookDetailScreen extends StatelessWidget {
  const EbookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Bhagavad Gita',
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Opacity(
            opacity: 0.57,
            child: Image.asset(
              'assets/images/bg4.jpg',
              // width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 20, 15, 40),
              child: Column(children: [
                Row(
                  children: [
                    Text('Bhagavad Gita',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                    Icon(
                      Icons.copy,
                      size: 30,
                      color: textColor,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 30,
                      color: textColor,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.share_outlined,
                      size: 30,
                      color: textColor,
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // About the book

                Text(
                    'श्रीमद्भगवद्‌गीता हिन्दुओं के पवित्रतम ग्रन्थों में से एक है। महाभारत के अनुसार कुरुक्षेत्र युद्ध में भगवान श्री कृष्ण ने गीता का सन्देश अर्जुन को सुनाया था। यह महाभारत के भीष्मपर्व के अन्तर्गत दिया गया एक उपनिषद् है। भगवत गीता में एकेश्वरवाद, कर्म योग, ज्ञानयोग, भक्ति योग की बहुत सुन्दर ढंग से चर्चा हुई है।\n\nश्रीमद्भगवद्‌गीता की पृष्ठभूमि महाभारत का युद्ध है। जिस प्रकार एक सामान्य मनुष्य अपने जीवन की समस्याओं में उलझकर किंकर्तव्यविमूढ़ हो जाता है और जीवन की समस्यायों से लड़ने की बजाय उससे भागने का मन बना लेता है उसी प्रकार अर्जुन जो महाभारत के महानायक थे, अपने सामने आने वाली समस्याओं से भयभीत होकर जीवन और क्षत्रिय धर्म से निराश हो गए थे, अर्जुन की तरह ही हम सभी कभी-कभी अनिश्चय की स्थिति में या तो हताश हो जाते हैं और या फिर अपनी समस्याओं से विचलित होकर भाग खड़े होते हैं।\n\nभारत वर्ष के ऋषियों ने गहन विचार के पश्चात जिस ज्ञान को आत्मसात किया उसे उन्होंने वेदों का नाम दिया। इन्हीं वेदों का अंतिम भाग उपनिषद कहलाता है। मानव जीवन की विशेषता मानव को प्राप्त बौद्धिक शक्ति है और उपनिषदों में निहित ज्ञान मानव की बौद्धिकता की उच्चतम अवस्था तो है ही, अपितु बुद्धि की सीमाओं के परे मनुष्य क्या अनुभव कर सकता है उसकी एक झलक भी दिखा देता है।\n\nश्रीमद्भगवद्गीता वर्तमान में धर्म से ज्यादा जीवन के प्रति अपने दार्शनिक दृष्टिकोण को लेकर भारत में ही नहीं विदेशों में भी लोगों का ध्यान अपनी और आकर्षित कर रही है। निष्काम कर्म का गीता का संदेश प्रबंधन गुरुओं को भी लुभा रहा है। विश्व के सभी धर्मों की सबसे प्रसिद्ध पुस्तकों में शामिल है। गीता प्रेस गोरखपुर जैसी धार्मिक साहित्य की पुस्तकों को काफी कम मूल्य पर उपलब्ध कराने वाले प्रकाशन ने भी कई आकार में अर्थ और भाष्य के साथ श्रीमद्भगवद्गीता के प्रकाशन द्वारा इसे आम जनता तक पहुंचाने में काफी योगदान दिया है।',
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        //color: Colors.white,
                        fontSize: 18)),
              ]),
            ),
          ),
        ],
      )),
    );
  }
}