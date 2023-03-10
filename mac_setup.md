# Mac setup

## Java

```bash
brew install jenv
echo 'eval "$(jenv init -)"' >> ~/.profile

brew install --cask microsoft-openjdk11
jenv add "$(/usr/libexec/java_home -v 11)"

brew install --cask adoptopenjdk8
jenv add "$(/usr/libexec/java_home -v 1.8)"

brew install --cask adoptopenjdk17
jenv add "$(/usr/libexec/java_home -v 17)"

/usr/libexec/java_home -V

## configure local java version
jenv local 11.0

## configure global java version
jenv global 11.0

## configure shell specific java
jenv shell 1.8

```
