#!/bin/bash

shopt -s nullglob
JDKS+=($HOME/.asdf/installs/java/*)

cat >JdkVersion.java <<EOF
public class JdkVersion {
  public static void main(String[] argv) {
    System.out.println(System.getProperty("java.specification.version"));
  }
}
EOF

javac -Xlint:none -source 1.7 -target 1.7 JdkVersion.java

echo '<?xml version="1.0" encoding="UTF-8"?>' >toolchains.xml
echo '<toolchains>' >>toolchains.xml

for jdk in ${JDKS[@]}; do
  if [ -d ${jdk} ]; then
    java=${jdk}/bin/java

    if [ -x ${java} ]; then
        version=$(${java} JdkVersion)
        vendor=$(basename ${jdk} | sed -e 's/^\([-a-z][-a-z]*\)-[0-9].*$/\1/')

        (
          echo "  <toolchain>"
          echo "    <type>jdk</type>"
          echo "    <provides>"
          echo "      <version>${version}</version>"
          echo "      <vendor>${vendor}</vendor>"
          echo "    </provides>"
          echo "    <configuration>"
          echo "      <jdkHome>${jdk}</jdkHome>"
          echo "    </configuration>"
          echo "  </toolchain>"
        ) >>toolchains.xml
    fi
  fi
done

echo '</toolchains>' >>toolchains.xml

rm -f JdkVersion.*
