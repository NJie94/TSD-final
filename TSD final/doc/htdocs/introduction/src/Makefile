# Create the ccdoc documentation if the header file changed.
../htdocs/ccdoc.db : ../htdocs ../export/hello_world.h
	rm -f ../htdocs/*
	ccdoc -db ../htdocs/ccdoc.db \
		../export/hello_world.h \
		-index \
		-root dreamers_inc \
		-rootfile ../htdocs/index.html \
		-html ../htdocs/

# Create the htdocs directory, if necessary.
../htdocs : ; @mkdir $@

# Clean target
clean :
	@rm -f ../htdocs/*

