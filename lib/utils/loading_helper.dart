class LoadingHelper {
  bool loading = false;

  bool starLoading() {
    loading = true;
    return loading;
  }

  bool stopLoading() {
    loading = false;
    return loading;
  }
}
