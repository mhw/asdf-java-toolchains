# asdf java maven toolchain.xml generator

This script generates a [`toolchains.xml` file](https://maven.apache.org/guides/mini/guide-using-toolchains.html)
for the [Maven Toolchains Plugin](https://maven.apache.org/plugins/maven-toolchains-plugin/).
The file contains entries for each JDK installed by the [asdf-java plugin](https://github.com/halcyon/asdf-java).

The script is based on [this one by Allen D. Ball](https://dev.to/allenball/maven-toolchains-xml-script-2lkm).
