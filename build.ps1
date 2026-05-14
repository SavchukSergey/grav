d:\wabt\bin\wat2wasm src/grav.wat -o dist/grav.wasm
d:\wabt\bin\wat2wasm src/grav.simd.wat -o dist/grav.simd.wasm
if (!$?) { Exit };
Copy-Item src/index.css dist/index.css
if (!$?) { Exit };
Copy-Item src/index.js dist/index.js
if (!$?) { Exit };

d:\wabt\bin\wasm2wat dist/grav.wasm -f -o dist/grav-decompiled.wat
d:\wabt\bin\wasm2wat dist/grav.simd.wasm -f -o dist/grav.simd-decompiled.wat
d:\wabt\bin\wasm-decompile dist/grav.wasm -o dist/grav-decompiled.c
d:\wabt\bin\wasm-decompile dist/grav.simd.wasm -o dist/grav.simd-decompiled.c
node tests/grav.test.js grav.wasm
node tests/grav.test.js grav.simd.wasm