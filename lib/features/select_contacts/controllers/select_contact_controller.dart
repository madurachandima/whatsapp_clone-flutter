import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/select_contacts/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider(
  (ref) {
    final selectContactRepo = ref.watch(selectContactRepositoryProvider);
    return selectContactRepo.getContacts();
  },
);

final selectContactControllerProvider = Provider(
  (ref) {
    final selectContactRepo = ref.watch(selectContactRepositoryProvider);
    return SelectContactController(
        ref: ref, selectContactRepo: selectContactRepo);
  },
);

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepo;

  SelectContactController({required this.ref, required this.selectContactRepo});

  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepo.selectContact(selectedContact, context);
  }
}
