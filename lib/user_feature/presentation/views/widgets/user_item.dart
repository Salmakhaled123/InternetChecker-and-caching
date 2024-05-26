import 'package:flutter/material.dart';
import 'package:userapp/user_feature/data/models/user_model.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.model}) : super(key: key);
  final UserModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xffFF0060),
              Color(0xff99DBF5),
            ],
          )),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(model.name),
        subtitle: Text(model.email),
      ),
    );
  }
}
