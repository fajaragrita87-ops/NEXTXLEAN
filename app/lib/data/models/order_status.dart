enum OrderStatus {
  orderMasuk,
  sortir,
  prosesCuci,
  prosesKering,
  prosesSetrika,
  qc,
  siapAmbilAtauAntar,
  diantar,
  selesai;

  static OrderStatus? fromString(String? value) {
    switch (value) {
      case 'orderMasuk':
        return OrderStatus.orderMasuk;
      case 'sortir':
        return OrderStatus.sortir;
      case 'prosesCuci':
        return OrderStatus.prosesCuci;
      case 'prosesKering':
        return OrderStatus.prosesKering;
      case 'prosesSetrika':
        return OrderStatus.prosesSetrika;
      case 'qc':
        return OrderStatus.qc;
      case 'siapAmbilAtauAntar':
        return OrderStatus.siapAmbilAtauAntar;
      case 'diantar':
        return OrderStatus.diantar;
      case 'selesai':
        return OrderStatus.selesai;
      default:
        return null;
    }
  }

  String get key => name;

  String get label {
    switch (this) {
      case OrderStatus.orderMasuk:
        return 'ORDER MASUK';
      case OrderStatus.sortir:
        return 'SORTIR';
      case OrderStatus.prosesCuci:
        return 'PROSES CUCI';
      case OrderStatus.prosesKering:
        return 'PROSES KERING';
      case OrderStatus.prosesSetrika:
        return 'PROSES SETRIKA';
      case OrderStatus.qc:
        return 'QC';
      case OrderStatus.siapAmbilAtauAntar:
        return 'SIAP AMBIL / ANTAR';
      case OrderStatus.diantar:
        return 'DIANTAR';
      case OrderStatus.selesai:
        return 'SELESAI';
    }
  }
}
