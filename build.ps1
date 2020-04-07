d:\wabt\wat2wasm src/grav.wat -o dist/grav.wasm
d:\wabt\wat2wasm src/grav.simd.wat --enable-simd -o dist/grav.simd.wasm
if (!$?) { Exit };
Copy-Item src/index.css dist/index.css
if (!$?) { Exit };
Copy-Item src/index.js dist/index.js
if (!$?) { Exit };

d:\wabt\wasm2wat dist/grav.wasm -f -o dist/grav-decompiled.wat
d:\wabt\wasm2wat dist/grav.simd.wasm -f --enable-simd -o dist/grav.simd-decompiled.wat
d:\wabt\wasm-decompile dist/grav.wasm -o dist/grav-decompiled.c
d:\wabt\wasm-decompile dist/grav.simd.wasm --enable-simd -o dist/grav.simd-decompiled.c
node tests/grav.test.js grav.wasm
node --experimental-wasm-simd tests/grav.test.js grav.simd.wasm