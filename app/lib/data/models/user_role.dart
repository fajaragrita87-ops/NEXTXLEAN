enum UserRole {
  owner,
  manager,
  kasir,
  staff,
  kurir,
  customer;

  static UserRole? fromString(String? value) {
    switch (value) {
      case 'owner':
        return UserRole.owner;
      case 'manager':
        return UserRole.manager;
      case 'kasir':
        return UserRole.kasir;
      case 'staff':
        return UserRole.staff;
      case 'kurir':
        return UserRole.kurir;
      case 'customer':
        return UserRole.customer;
      default:
        return null;
    }
  }

  String get key => name;
}

