enum PaymentType { Wallet, Cash, Pos }

extension PaymentTypeExtention on PaymentType {
  int getValue() {
    switch (this) {
      case PaymentType.Wallet:
        {
          return 1;
        }

      case PaymentType.Cash:
        {
          return 2;
        }

      case PaymentType.Pos:
        {
          return 3;
        }
    }
  }
}
