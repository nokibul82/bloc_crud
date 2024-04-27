import 'package:bloc_crud/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/user/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Block CRUD"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserUpdated && state.users.isNotEmpty) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            name.text = user.name;
                            email.text = user.email;
                            showBottom(
                                context: context, id: user.id, isEdit: true);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            context
                                .read<UserBloc>()
                                .add(DeleteUser(user: user));
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No item"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final state = BlocProvider.of<UserBloc>(context).state;
          final id = state.users.length + 1;
          showBottom(context: context, id: id);
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future showBottom(
      {required BuildContext context, bool isEdit = false, required int id}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.all( 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Name')),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Email'),
              ),
              ElevatedButton(
                  onPressed: () {
                    final user =
                        User(id: id, email: email.text, name: name.text);

                    if (isEdit) {
                      context.read<UserBloc>().add(UpdateUser(user: user));
                    } else {
                      context.read<UserBloc>().add(AddUser(user: user));
                    }
                    name.clear();
                    email.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          ),
        );
      },
    );
  }
}
