class CekAdminStatus {
  cekStatusRole(int? status) {
    switch (status) {
      case 0:
        return 'user';
      case 1:
        return 'admin';
      case 2:
        return 'approval 0';
      case 3:
        return 'approval 1';
      case 4:
        return 'approval 2';
      case 5:
        return 'approval 3';
      case 6:
        return 'approval 4';
      case 7:
        return 'approval 5';
      default:
    }
  }
}
