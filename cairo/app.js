
console.log("aaaaaaaaaaaaaa");

WebAssembly.instantiateStreaming(fetch("output.wasm"), importObject).then(
    (results) => {
      console.log("gfds");
    },
  );
  