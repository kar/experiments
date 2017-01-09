# Buck experiments

This repo contains examples of various non-trivial buck configurations and use case scenarios.

So far it means:

- Buck + Kotlin + Android
-- Build Kotlin code with Android dependencies (including generated R.java)

# How to run it

- `cp ~/.android/debug.keystore apps/gs.kar.buckexp/`
- `cd lib/kotlin && ln -s /path/to/kotlin-runtime.jar`
- `chmod u+x kotlin/gs.kar.buckexp/kotlincw`
- Have `kotlinc` on your $PATH
- `make all install`
