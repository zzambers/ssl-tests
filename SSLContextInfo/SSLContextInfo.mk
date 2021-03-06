SSLCONTEXTINFO_SRC_DIR = $(SSLCONTEXTINFO_DIR)/src
SSLCONTEXTINFO_MAIN_CLASS = SSLContextInfo

.PHONY: SSLContextInfo SSLContextInfo-clean SSLContextInfo-build SSLContextInfo-run

SSLContextInfo: SSLContextInfo-run

SSLContextInfo-clean:
	rm -rf $(SSLCONTEXTINFO_CLASSES_DIR)

SSLContextInfo-build: $(SSLCONTEXTINFO_CLASSES_DIR)

SSLContextInfo-run: $(SSLCONTEXTINFO_CLASSES_DIR)
	$(JAVA) -cp $< $(SSLCONTEXTINFO_MAIN_CLASS)

$(SSLCONTEXTINFO_CLASSES_DIR): $(SSLCONTEXTINFO_SRC_DIR)
	mkdir -p $@
	$(JAVAC) -encoding UTF-8 -g -d $@ $</*

