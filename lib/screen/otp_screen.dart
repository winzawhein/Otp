import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encryptPackage;
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String decryptedText = '';
  bool isTrue=false;
  Color color=Colors.grey;
  TextEditingController pinController = TextEditingController();
  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();
  final TextEditingController otp5Controller = TextEditingController();
  final TextEditingController otp6Controller = TextEditingController();
  Color pinBorderColor = Colors.black;
 
  Widget _phoneOTP(
      {required bool first, last, required TextEditingController controller}) {
    return SizedBox(
      height: 70,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blue),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(width: 2, color: color),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(width: 2, color: color),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  void makeHttpRequest(BuildContext context) async {
    final url = Uri.parse('https://otp-request.onrender.com/get-otp');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decrypt the response using AES ECB 256
      final secretKey = '12345678123456781234567812345678';
      final encryptedText = response.body;
    final pText= encryptedText.split(',').first.substring(9,33);
      final key = encryptPackage.Key.fromUtf8(secretKey);
      final iv = encryptPackage.IV.fromLength(16);
      final encrypter =
          encryptPackage.Encrypter(encryptPackage.AES(key, mode: encryptPackage.AESMode.ecb));
      final decryptedText = encrypter.decrypt64(pText, iv: iv);
      print("decode=> $decryptedText");
      // Extract the OTP codes
      final otpCodes = decryptedText.split(' ');

      setState(() {
        this.decryptedText = decryptedText;
      });

      // Show the SnackBar with the decrypted OTP codes
     
       Get.snackbar(
              'Code',
              decryptedText,
              snackPosition: SnackPosition.TOP, // Set the snackbar position to top
              backgroundColor: Colors.grey, // Customize the snackbar background color
              colorText: Colors.white, // Customize the snackbar text color
              duration:const Duration(seconds: 5), // Set the snackbar duration
            );

      // Show the bottom sheet with a pin input TextField
     
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var otp=otp1Controller.text+otp2Controller.text+otp3Controller.text+otp4Controller.text+otp5Controller.text+otp6Controller.text;
          if(otp==decryptedText){
            print("true");
            setState(() {
              color=Colors.green;
              // print("color=> $color");
            });
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("OTP ကုဒ်နံပါတ် ြဖည့်ပါ"),
              Text("တစ်ခါသုံး ကုဒ် ြဖစ်သောကြောင့် ၁ မိနစ်အတွင်းထည့်သွင်းပါ"),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  _phoneOTP(first: true
                  , controller: otp1Controller),
                  _phoneOTP(first: true
                  , controller: otp2Controller),
                  _phoneOTP(first: true
                  , controller: otp3Controller),
                  _phoneOTP(first: true
                  , controller: otp4Controller),
                  _phoneOTP(first: true
                  , controller: otp5Controller),
                  _phoneOTP(first: true
                  , controller: otp6Controller),
                ],),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  width: Get.width,
                  
                  child:  Center(child: Text('အတည်ပြုမည်။')),
                ),
            ],),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed:()=> makeHttpRequest(context),
          child:const Text('Otp တောင်းမည်'),
        ),
      ),
    );
  }
}
