# Android 릴리스 절차

첫 직접 설치 배포 대상: `v0.2.0`, 앱 버전 `0.2.0+2`, DB v2. Android 범용 APK를 GitHub 사전 릴리스로 제공하는 범위. Play Store 등록·iOS 배포는 별도 작업.

## 앱 식별자와 서명

- 현재 applicationId: `com.example.miruvor`. 기존 로컬 데이터 경로의 앱 정체성 유지; 스토어용 식별자 전환은 데이터 이전 방식과 함께 별도 결정.
- release 빌드는 앱 전용 서명 설정 필수. debug 키로 자동 대체하지 않으며 설정 누락 시 빌드 중단.
- 비공개 파일: `android/key.properties`, `android/keystores/miruvor-release.jks`. Git 제외 대상이며 소스·릴리스 첨부에 포함 금지.
- 다른 개발 환경에서는 기존 서명 파일을 안전하게 옮기고 [예제 설정](../android/key.properties.example)을 참고해 `key.properties` 구성. `storeFile`은 android 폴더 기준 경로.
- 서명 키와 암호의 안전한 별도 백업 필요. 업데이트에는 같은 앱 ID와 서명 키 사용. 새 키 생성으로 분실한 키를 대체해도 기존 설치 앱의 업데이트는 불가.
- 이전 debug 서명 앱이 설치되어 있다면 이번 전용 서명 APK와 인증서가 달라 덮어쓰기 설치 불가. 사용자 데이터가 있는 앱을 삭제해 해결하지 말고 먼저 보존·이전 방안 확인. 현재 앱의 사용자용 사진 포함 백업·복원은 미구현.

서명·업데이트 관계: [Android 공식 서명 안내](https://developer.android.com/studio/publish/app-signing). Flutter 설정과 APK 빌드: [Flutter Android 배포 안내](https://docs.flutter.dev/deployment/android).

## 빌드와 검증

Flutter 및 Android SDK/JDK가 준비된 저장소 루트에서 실행:

```powershell
flutter pub get
flutter analyze --no-pub
flutter test --no-pub --reporter expanded
flutter build apk --release --no-pub
```

출력: `build/app/outputs/flutter-apk/app-release.apk`. 기기 아키텍처를 따로 고를 필요가 없는 범용 설치 파일.

배포 전 확인:

1. APK 안의 앱 ID·versionName·versionCode·지원 ABI 및 debuggable 여부 확인.
2. Android SDK `apksigner verify --verbose --print-certs`로 서명 검증. 인증서의 SHA-256 지문만 배포 메타데이터에 기록.
3. 파일의 SHA-256 계산 후 `SHA256SUMS.txt`와 함께 배포 폴더에 복사.
4. 소스 커밋·태그가 실제 빌드 입력과 일치하는지 확인. 미검증인 기기 실행·업그레이드·권한 동작은 릴리스 설명에 명시.
5. GitHub 업로드 후 내려받은 APK의 SHA-256을 로컬 원본과 대조.

`build/releases/`는 로컬 산출물 경로이며 Git 추적 대상에서 제외. 키·암호·기기 개인 데이터는 배포 폴더에 포함 금지.

## 배포 범위

자동 테스트와 APK 빌드·정적 검증은 실제 기기 실행 검증과 별개. 첫 배포는 사전 릴리스로 표시하며, Android 실기기의 사진 권한·카메라·재시작과 실제 사용자 v1 데이터 업데이트는 후속 확인 대상.

iOS 릴리스는 macOS/Xcode와 Apple 서명·배포 설정 필요. 이 Windows 환경에서 Android APK가 만들어졌다는 사실로 iOS 배포 완료를 표시하지 않는 기준.
