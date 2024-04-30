import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_fic14/data/datasources/product_local_datasource.dart';
import 'package:resto_fic14/data/datasources/product_remote_datasource.dart';
import 'package:resto_fic14/data/models/response/product_response_model.dart';
import 'package:resto_fic14/presentation/settings/bloc/sync_product/sync_product_bloc.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Data'),
      ),
      body: Column(
        children: [
          BlocConsumer<SyncProductBloc, SyncProductState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (error) {
                  return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                loaded: (productResponseModel) {
                  // print("kene");
                  ProductLocalDataSource.instance.deleteAllProduct();
                  ProductLocalDataSource.instance
                      .insertProducts(productResponseModel.data!);
                  return ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(' Success sync data'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<SyncProductBloc>()
                          .add(const SyncProductEvent.syncProduct());
                    },
                    child: const Text('Sync Data'),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
