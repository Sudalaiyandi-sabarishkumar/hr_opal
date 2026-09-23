case "$CONFIGURATION" in
  *-dev) cp Runner/dev/GoogleService-Info.plist Runner/GoogleService-Info.plist ;;
  *-staging) cp Runner/staging/GoogleService-Info.plist Runner/GoogleService-Info.plist ;;
esac
