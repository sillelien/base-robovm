#!/usr/bin/env ash

BASE=$(cd "$(dirname "$0")/.."; pwd -P)
COMPILER_JAR="$BASE/lib/robovm-dist-compiler.jar"
if [ -f "$COMPILER_JAR" ]; then
    export ROBOVM_HOME="$BASE"
else
    if [ "x$ROBOVM_DEV_ROOT" != 'x' ]; then
        COMPILER_JAR=$(ls "$ROBOVM_DEV_ROOT"/../robovm-dist/compiler/target/robovm-dist-compiler*.jar | egrep -v 'javadoc|sources' 2> /dev/null)
    fi
fi
if [ ! -f "$COMPILER_JAR" ]; then
  echo "robovm-dist-compiler.jar not found"
  exit 1
fi

[ "x$JVM_MX" == 'x' ] && JVM_MX="2g"

java -XX:+HeapDumpOnOutOfMemoryError -Xss1024k -Xmx$JVM_MX $JVM_OPTS -jar "$COMPILER_JAR" "$@"

