

clean:
	rm -rf out/*

ver:
	while inotifywait -e close_write ./*; do clear; dafny verify ./src/formal.dfy; done

# compile src files to out folder
verify:
	while inotifywait -e close_write ./*; do clear; dafny verify ./src/*.dfy; done

v1:
	while inotifywait -e close_write ./util/**; do clear; dafny verify ./src/util/*.dfy; done

# compile src files to out folder
compile:
	while inotifywait -e close_write ./*; do clear; dafny ./src/hello.dfy /out:./out/hello; done


build:
	dafny build ./src/${f}.dfy -o ./out/${f}


run:
	./out/hello.exe
