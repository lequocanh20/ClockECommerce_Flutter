import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Users> listUsers = [];
  final email = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  // LoginResponseModel? model;
  @override
  void initState() {
    super.initState();
    _getData();    
  }
  _getData() async {
    // model = await SharedService.loginDetails();
    // email.text = model!.name;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await users.get().then((value) {
      for (var doc in value.docs) {
        listUsers.add(Users(id: doc.get('Id'), name: doc.get('Name'), address: doc.get('Address'), 
        email: doc.get('Email'), phone: doc.get('Phone')));      
      }
    });
    // var model = await APIService.getUserProfile();
    // email.text = model.resultObj.email;
    // name.text = model.resultObj.name;
    // phone.text = model.resultObj.phoneNumber;
    // address.text = model.resultObj.address;
    for (var i = 0; i < listUsers.length; i++) {
      var element = listUsers.elementAt(i);
      if (element.id == uid) {
        email.text = element.email;
        name.text = element.name;
        phone.text = element.phone;
        address.text = element.address;
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    void _changePassword(String currentPassword, String newPassword) async {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: currentPassword);

      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          //Success, do something
          Fluttertoast.showToast(
              msg: "Đổi mật khẩu thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }).catchError((error) {
          //Error, show something
          Fluttertoast.showToast(
              msg: "Đổi mật khẩu thất bại",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
      }).catchError((err) {
        Fluttertoast.showToast(
            msg: "Mật khẩu cũ không chính xác",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
    return SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 5,),
            nameTextFormField(),
            const SizedBox(height: 5,),
            addressTextFormField(),
            const SizedBox(height: 5,),
            phoneTextFormField(),
            const SizedBox(height: 5,),
            emailTextFormField(),
            const SizedBox(height: 5,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, email.text);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: kPrimaryColor,
                child: TextButton(
                  child: Text("Lưu thông tin cá nhân", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  onPressed: () => {
                    
                  }
                  ),
                ),
            ),
            const SizedBox(height: 20,),
            Text("Đổi mật khẩu", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 5,),
            currentPasswordTextFormField(),
            const SizedBox(height: 5,),
            newPassWordTextFormField(),
            const SizedBox(height: 5,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, email.text);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: kPrimaryColor,
                child: TextButton(
                  child: Text("Xác nhận đổi mật khẩu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  onPressed: () => {
                    _changePassword(currentPassword.text, newPassword.text)
                  }
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField nameTextFormField() {
    return TextFormField(
      controller: name,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Tên",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField addressTextFormField() {
    return TextFormField(
      controller: address,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Địa chỉ",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField phoneTextFormField() {
    return TextFormField(
      controller: phone,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Số điện thoại",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Email",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField newPassWordTextFormField() {
    return TextFormField(
      obscureText: true,
      controller: newPassword,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Mật khẩu mới",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)
      ),
    );
  }


  TextFormField currentPasswordTextFormField() {
    return TextFormField(
      obscureText: true,
      controller: currentPassword,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Mật khẩu hiện tại",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)
      ),
    );
  }
}
