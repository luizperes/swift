// RUN: echo "{\"%s\": {\"object\": \"/build/basic_output_file_map.o\"}, \"%S/Inputs/main.swift\": {\"object\": \"/build/main.o\"}, \"%S/Inputs/lib.swift\": {\"object\": \"/build/lib.o\"}}" > %t.json

// RUN: %swift_driver -driver-print-output-file-map -target x86_64-apple-macosx10.9 -emit-executable %s %S/Inputs/main.swift %S/Inputs/lib.swift -o /build/basic_output_file_map.out -module-name OutputFileMap -output-file-map %t.json 2>&1 | FileCheck %s -check-prefix=DUMPOFM
// RUN: %swift_driver -driver-print-bindings -target x86_64-apple-macosx10.9 -emit-executable %s %S/Inputs/main.swift %S/Inputs/lib.swift -o /build/basic_output_file_map.out -module-name OutputFileMap -output-file-map %t.json 2>&1 | FileCheck %s -check-prefix=BINDINGS

// DUMPOFM: {{.*}}/Inputs/lib.swift -> object: "/build/lib.o"
// DUMPOFM: {{.*}}/Inputs/main.swift -> object: "/build/main.o"
// DUMPOFM: {{.*}}/basic_output_file_map.swift -> object: "/build/basic_output_file_map.o"

// BINDINGS: # "x86_64-apple-macosx10.9" - "swift", inputs: ["{{.*}}/basic_output_file_map.swift"], output: {object: "/build/basic_output_file_map.o"}
// BINDINGS: # "x86_64-apple-macosx10.9" - "swift", inputs: ["{{.*}}/Inputs/main.swift"], output: {object: "/build/main.o"}
// BINDINGS: # "x86_64-apple-macosx10.9" - "swift", inputs: ["{{.*}}/Inputs/lib.swift"], output: {object: "/build/lib.o"}
// BINDINGS: # "x86_64-apple-macosx10.9" - "darwin::Linker", inputs: ["/build/basic_output_file_map.o", "/build/main.o", "/build/lib.o"], output: {image: "/build/basic_output_file_map.out"}
