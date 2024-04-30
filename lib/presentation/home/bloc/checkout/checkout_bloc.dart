import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resto_fic14/data/models/response/product_response_model.dart';

import '../../models/product_qty.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddItem>((event, emit) async {
      var currentState = state as _Loaded;
      List<ProductQty> items = [...currentState.items];
      var index =
          items.indexWhere((element) => element.product.id == event.product.id);
      emit(const _Loading());
      if (index != -1) {
        items[index] =
            ProductQty(product: event.product, qty: items[index].qty + 1);
      } else {
        items.add(ProductQty(product: event.product, qty: 1));
      }
      emit(_Loaded(items));
    });
    on<_RemoveItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQty> items = currentState.items;
      var index =
          items.indexWhere((element) => element.product.id == event.product.id);
      if (index != -1) {
        if (items[index].qty > 1) {
          items[index] =
              ProductQty(product: event.product, qty: items[index].qty - 1);
        } else {
          items.removeAt(index);
        }
      }
      emit(_Loaded(items));
    });
  }
}
