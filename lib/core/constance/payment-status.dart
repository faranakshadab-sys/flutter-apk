enum PaymentStatus { Pending, Paid }

extension PaymentStatusExtention on PaymentStatus {
  PaymentStatus getById(int id) {
    switch (id) {
      case 1:
        {
          return PaymentStatus.Pending;
        }
      case 2:
        {
          return PaymentStatus.Paid;
        }

      default:
        {
          return PaymentStatus.Pending;
        }
    }
  }
}
