part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  //add_item
  const factory CheckoutEvent.addItem(Product product) = _AddItem;
  //remove_item
  const factory CheckoutEvent.removeItem(Product product) = _RemoveItem;
}
