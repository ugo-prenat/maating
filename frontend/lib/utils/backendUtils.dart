import '../constants.dart' as constants;

String getBackendUrl() {
  const backEnv = String.fromEnvironment('BACK_ENV');
  if (backEnv == 'remote') return constants.REMOTE_BACK_URL;
  return constants.DEV_BACK_URL;
}
