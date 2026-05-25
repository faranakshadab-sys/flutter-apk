abstract class AppUseCase<R, P> {
  Future<R> call({required P params});
}
