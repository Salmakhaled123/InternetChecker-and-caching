import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:userapp/user_feature/presentation/view_model/user_data_cubit.dart';
import 'package:userapp/user_feature/presentation/views/widgets/user_item.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late StreamSubscription<InternetConnectionStatus> _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "Please check your internet connection",
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            StreamBuilder(
                stream: InternetConnectionChecker().onStatusChange,
                builder: (context, snapshot) {
                  if (snapshot.data == InternetConnectionStatus.disconnected) {
                    return const Icon(
                      Icons.circle,
                      color: Colors.red,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Icon(
                      Icons.circle,
                      color: Colors.yellow,
                    );
                  } else {
                    return const Icon(
                      Icons.circle,
                      color: Colors.green,
                    );
                  }
                })
          ],
          title: const Text(
            'Users',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserDataSuccess) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.users.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Animate(
                      effects: const [
                        FadeEffect(),
                        SlideEffect(),
                      ],
                      delay: Duration(milliseconds: index * 200),
                      child: UserItem(
                        model: state.users[index],
                      )),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
