
class PreloadingSize {
  String? aprId01;
  String? aprId02;
  String? aprId03;
  String? aprId04;
  String? aprId05;
  String? aprId06;
  String? aprId07;
  String? aprId08;
  String? aprId09;
  String? aprId10;
  String? size01;
  String? size02;
  String? size03;
  String? size04;
  String? size05;
  String? size06;
  String? size07;
  String? size08;
  String? size09;
  String? size10;

  String valueOf(int index) {
    switch (index) {
      case 1:
        return size01 ?? '0';
      case 2:
        return size02 ?? '0';
      case 3:
        return size03 ?? '0';
      case 4:
        return size04 ?? '0';
      case 5:
        return size05 ?? '0';
      case 6:
        return size06 ?? '0';
      case 7:
        return size07 ?? '0';
      case 8:
        return size08 ?? '0';
      case 9:
        return size09 ?? '0';
      case 10:
        return size10 ?? '0';
      default:
        return '-';
    }
  }

  String? actualAprId() {
    if ((int.tryParse(size01 ?? '') ?? 0) > 0) {
      return aprId01;
    }
    if ((int.tryParse(size02 ?? '') ?? 0) > 0) {
      return aprId02;
    }
    if ((int.tryParse(size03 ?? '') ?? 0) > 0) {
      return aprId03;
    }
    if ((int.tryParse(size04 ?? '') ?? 0) > 0) {
      return aprId04;
    }
    if ((int.tryParse(size05 ?? '') ?? 0) > 0) {
      return aprId05;
    }
    if ((int.tryParse(size06 ?? '') ?? 0) > 0) {
      return aprId06;
    }
    if ((int.tryParse(size07 ?? '') ?? 0) > 0) {
      return aprId07;
    }
    if ((int.tryParse(size08 ?? '') ?? 0) > 0) {
      return aprId08;
    }
    if ((int.tryParse(size09 ?? '') ?? 0) > 0) {
      return aprId09;
    }
    if ((int.tryParse(size10 ?? '') ?? 0) > 0) {
      return aprId10;
    }
    return null;
  }

  String? aprIdOfIndex(int index) {
    switch (index) {
      case 1:
        return aprId01;
      case 2:
        return aprId02;
      case 3:
        return aprId03;
      case 4:
        return aprId04;
      case 5:
        return aprId05;
      case 6:
        return aprId06;
      case 7:
        return aprId07;
      case 8:
        return aprId08;
      case 9:
        return aprId09;
      case 10:
        return aprId10;
    }
    return null;
  }

  String? actualQty() {
    if ((int.tryParse(size01 ?? '') ?? 0) > 0) {
      return size01;
    }
    if ((int.tryParse(size02 ?? '') ?? 0) > 0) {
      return size02;
    }
    if ((int.tryParse(size03 ?? '') ?? 0) > 0) {
      return size03;
    }
    if ((int.tryParse(size04 ?? '') ?? 0) > 0) {
      return size04;
    }
    if ((int.tryParse(size05 ?? '') ?? 0) > 0) {
      return size05;
    }
    if ((int.tryParse(size06 ?? '') ?? 0) > 0) {
      return size06;
    }
    if ((int.tryParse(size07 ?? '') ?? 0) > 0) {
      return size07;
    }
    if ((int.tryParse(size08 ?? '') ?? 0) > 0) {
      return size08;
    }
    if ((int.tryParse(size09 ?? '') ?? 0) > 0) {
      return size09;
    }
    if ((int.tryParse(size10 ?? '') ?? 0) > 0) {
      return size10;
    }
    return null;
  }
}