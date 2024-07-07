import 'package:flutter/material.dart';
import 'package:kro_banking/bloc/bloc_provider.dart';
import 'package:kro_banking/repository/repository_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRepositoriesProvider(
      child: AppBlocProvider(
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text("tesinog "),
            ),
          ),
        ),
        // child: MaterialApp.router(
        //   theme: AppTheme.theme,
        //   debugShowCheckedModeBanner: false,
        //   routerConfig: AppRouter.router,
        //   builder: (context, child) {
        //     final loadingState = context.watch<LoadingCubit>().state;
        //     return _buildApp(context, child, loadingState);
        //   },
        // ),
      ),
    );
  }
}
