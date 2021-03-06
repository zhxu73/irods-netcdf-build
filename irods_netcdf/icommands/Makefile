


# =-=-=-=-=-=-=-
# build execs and options
GCC = g++
LDR = g++

# =-=-=-=-=-=-=-
# Directories
objDir = obj
binDir = bin
srcDir = src

#
# Source files
#
OBJS =  $(objDir)/inc.o \
		$(objDir)/incarch.o \
		$(objDir)/incattr.o


BINS =		\
		$(binDir)/inc \
		$(binDir)/incarch  \
		$(binDir)/incattr

# =-=-=-=-=-=-=-
# libraries
BOOST_DIR=/usr/lib/irods/externals
BOOST_LIBS = \
             $(BOOST_DIR)/libboost_filesystem.a \
             $(BOOST_DIR)/libboost_system.a \
             $(BOOST_DIR)/libboost_regex.a \
             $(BOOST_DIR)/libboost_thread.a \
             $(BOOST_DIR)/libboost_program_options.a \
             $(BOOST_DIR)/libboost_chrono.a

LIBRARY = ../api/libirods_netcdf_client.a \
	/usr/lib/libirods_client_core.a \
	/usr/lib/libirods_client_api_table.a \
	/usr/lib/libirods_client_plugins.a

LDFLAGS += -L/usr/lib/irods/externals
LDFLAGS += -Wl,-rpath -Wl,/usr/lib/irods/externals
LDFLAGS +=	$(LIBRARY)
# ********* LDFLAGS += -lirods_client_core -lirods_client_plugins -lirods_client_api_table
LDFLAGS += $(BOOST_LIBS)
LDFLAGS += -lhdf5 -lnetcdf -lhdf5_hl -ljansson -rdynamic -lrt -ldl -lcurl -lz -lssl -lcrypto -lpthread

CFLAGS += -Wno-write-strings -DADDR_64BITS -Dlinux_platform -DNETCDF_API
CFLAGS += -I/usr/include/irods \
		  -I/usr/include/irods/boost \
		  -I/usr/include/irods/netcdf/include \
		  -I../api/include/ \
		  $(CFLAGS_OPTIONS) \
		  $(LIB_INCLUDES) \
		  $(SVR_INCLUDES) \
		  $(MODULE_CFLAGS)

CFLAGS_OPTIONS := -g $(CFLAGS) $(MY_CFLAG)

# =-=-=-=-=-=-=-
# Principal Targets
.PHONY: all icommands clients clean
all:	icommands
	@true

clients: icommands
	@true

icommands: $(OBJS) $(BINS)
	@true

$(objDir)/%.o:	$(srcDir)/%.cpp
	@echo "Compile icommand `basename $@`..."
	@$(GCC) -c $(CFLAGS) -o $@ $<

$(binDir)/%:	$(objDir)/%.o
	@echo "Link icommand `basename $@`..."
	@$(LDR) -o $@ $< $(LDFLAGS)

# Show compile flags
print_cflags:
	@echo "Compile flags:"
	@echo "    $(CFLAGS_OPTIONS)"

# Show link flags
print_ldflags:
	@echo "Link flags:"
	@echo "    $(LDFLAGS)"

# Clean
clean:
	@echo "Cleaning icommands..."
	@rm -f $(BINS) $(OBJS)

