
all:
	runhaskell Setup.hs build

conf:
	runhaskell Setup.hs configure --user 

doc:
	runhaskell Setup.hs haddock

clean:
	rm -f tests/pngsuite/*.bmp

test:
	dist\build\imageTest\imageTest.exe
