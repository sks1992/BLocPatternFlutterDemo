import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/blocs/app_blocs.dart';
import 'package:flutter_bloc_pattern/blocs/app_events.dart';
import 'package:flutter_bloc_pattern/blocs/app_states.dart';
import 'package:flutter_bloc_pattern/service/user_service.dart';

import 'model/user_model.dart';

//https://www.youtube.com/watch?v=CjCTNPKhgXc&ab_channel=dbestech
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'the bloc app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RepositoryProvider(
          create: (context) => UserService(),
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserService>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("The BLoC App"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              List<UserModel> userList = state.user;
              // return const  Center(child: Text("The Second State"),);

              return ListView.builder(
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.blue,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          userList[index].firstName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          userList[index].lastName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: CircleAvatar(
                          backgroundImage: NetworkImage(userList[index].avatar),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: userList.length,
              );
            }

            if (state is UserErrorState) {
              return const Center(
                child: Text("Error :SomeThing Went Wrong"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
