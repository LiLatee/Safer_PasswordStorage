FIREBASE_DISTRIBUTE ?= firebase appdistribution:distribute

CHAMBER_VERSION=v2.10.3
CHAMBER_CLI ?= chamber
CHAMBER_COMMAND ?= $(CHAMBER_CLI) exec safer --

SECRETS_BUCKET ?= safer-secrets

FIREBASE_APP_DISTRIBUTION_KEY ?= s3://$(SECRETS_BUCKET)/firebase_app_distribution_key.json


download-keys-Linux: ## [Linux] Downloads android keystore from S3
	@echo "Downloading FIREBASE_APP_DISTRIBUTION_KEY.."
	@aws s3 cp $(FIREBASE_APP_DISTRIBUTION_KEY) ./
	@export GOOGLE_APPLICATION_CREDENTIALS=./firebase_app_distribution_key.json
	@ls

chamber-Linux: ## [Linux] Install Chamber on Linux
ifeq ($(shell which chamber 2> /dev/null),)
	@echo "Installing chamber from GH release.."
	@curl -LOs https://github.com/segmentio/chamber/releases/download/$(CHAMBER_VERSION)/chamber-$(CHAMBER_VERSION)-linux-amd64
	@chmod +x ./chamber-$(CHAMBER_VERSION)-linux-amd64
	@mv ./chamber-$(CHAMBER_VERSION)-linux-amd64 /usr/local/bin/chamber
else
	@echo "chamber already installed.."
endif

ensure-firebase-cli-Linux: ## [Linux] Install firebase cli
ifeq ($(shell which firebase 2> /dev/null),)
	@echo "Installing firebase cli"
	@curl -o /usr/local/bin/firebase -Ls https://firebase.tools/bin/linux/latest
	@chmod a+x /usr/local/bin/firebase
else
	@echo "firebase cli already installed"
endif


build-Linux: ## [Linux] Build the app for android (apk and aab)
	@echo "Building android apk..."
	@echo "PRINT: make chamber-Linux"
	make chamber-Linux
	@echo "PRINT download-keys-Linux"
	make download-keys-Linux
	flutter pub get
	flutter build apk --debug --no-pub --no-sound-null-safety
	flutter build appbundle --debug --no-pub --no-sound-null-safety

upload-app-to-production-Linux: ensure-firebase-cli-Linux ## [Linux] Upload android aab to firebase
	@echo "Uploading android app to Firebase distribution..."
	@$(CHAMBER_COMMAND) bash -c '$(FIREBASE_DISTRIBUTE) build/app/outputs/bundle/debug/app-debug.aab --app $$FIREBASE_ANDROID_APP_ID --groups $$FIREBASE_DISTRIBUTION_GROUPS'